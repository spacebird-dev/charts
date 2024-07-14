#! /usr/bin/env python3

# chart-version-updater.py
#
# Commands for managing the version and appVersion in a Helm chart.
# Can adjust the appVersion according to an upstream release or set the chart version to a fixed value
#
# For appVersion, the script checks if an upstream project has been updated and if so,
# whether the version difference to the current appVersion is major, minor or patch.
# It then bumps the appVersion and outputs the change size (major/minor/patch).
#
# For version, the script just sets the desired version in Chart.yaml

import argparse
from dataclasses import dataclass
import logging
from pathlib import Path

import requests
from semver import VersionInfo
import yaml

CHARTS_PATH = Path("./charts")


logging.basicConfig(format='%(message)s', level=logging.INFO)
log = logging.getLogger("chart-version-updater")


@dataclass
class Chart:
    name: str

    def _get_version_field(self, field: str) -> VersionInfo:
        with open(CHARTS_PATH / self.name / "Chart.yaml", encoding="utf-8") as f:
            return VersionInfo.parse(str(yaml.safe_load(f)[field]))

    def _set_version_field(self, field: str, ver: VersionInfo):
        content = {}
        with open(CHARTS_PATH / self.name / "Chart.yaml", encoding="utf-8") as f:
            content = yaml.safe_load(f)
        content[field] = str(ver)
        with open(CHARTS_PATH / self.name / "Chart.yaml", "w", encoding="utf-8") as w:
            yaml.safe_dump(content, w, allow_unicode=True)

    @property
    def app_version(self) -> VersionInfo:
        return self._get_version_field("appVersion")

    @app_version.setter
    def app_version(self, value):
        self._set_version_field("appVersion", value)

    @property
    def version(self) -> VersionInfo:
        return self._get_version_field("version")

    @version.setter
    def version(self, value):
        self._set_version_field("version", value)

    @property
    def repo(self) -> str:
        with open(CHARTS_PATH / self.name / "Chart.yaml", encoding="utf-8") as f:
            return yaml.safe_load(f)["sources"][0].removeprefix("https://github.com/")


def get_upstream_version(repo: str, tag_prefix: str = "") -> VersionInfo:
    response = requests.get(
        f"https://api.github.com/repos/{repo}/releases/latest")
    response.raise_for_status()
    return VersionInfo.parse(response.json()["tag_name"].removeprefix(tag_prefix))


def app_version(chart: Chart, args: argparse.Namespace):
    log.info(f"Current appVersion: {chart.app_version}")
    upstream_version = get_upstream_version(chart.repo, args.tag_prefix)
    log.info(f"Detected upstream version: {upstream_version}")

    if chart.app_version == upstream_version:
        log.info("Nothing to do")
        return
    if chart.app_version > upstream_version:
        raise ValueError(
            "Upstream version is lower than current appVersion, aborting")
    if upstream_version.prerelease:
        raise ValueError("New appVersion is a pre-release, aborting")

    if chart.app_version.major < upstream_version.major:
        print("major")
    elif chart.app_version.minor < upstream_version.minor:
        print("minor")
    elif chart.app_version.patch < upstream_version.patch:
        print("patch")
    else:
        raise ValueError(
            f"Could not determine version difference: {chart.app_version} vs {upstream_version}")

    if not args.dry_run:
        log.info(f"Updating appVersion to {upstream_version}")
        chart.app_version = upstream_version


def version(chart: Chart, args: argparse.Namespace):
    log.info(f"Current version: {chart.version}")
    new_version = VersionInfo.parse(args.VERSION)
    log.info(f"New version: {new_version}")

    if new_version != chart.version:
        chart.version = new_version
    else:
        log.info("Nothing to do")


def main():
    parser = argparse.ArgumentParser(
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    task = parser.add_subparsers(dest="TASK", help="The task to perform")
    parser.add_argument("--dry-run", action="store_true",
                        help="Do not update Chart.yaml, only output the version bump size")

    app_version_args = task.add_parser(
        "appVersion", help="Bump the charts appVersion to the latest upstream release and output the change size")
    app_version_args.add_argument(
        "CHART", help=f"Name of the chart in {CHARTS_PATH} to update")
    app_version_args.add_argument(
        "--tag-prefix", help="Prefix to strip from the release tags", default="v")

    version_args = task.add_parser("version", help="Set the charts version")
    version_args.add_argument(
        "CHART", help=f"Name of the chart in {CHARTS_PATH} to update")
    version_args.add_argument(
        "VERSION", help="Set the chart version to this value")
    args = parser.parse_args()

    chart = Chart(args.CHART)

    if args.TASK == "appVersion":
        app_version(chart, args)
    elif args.TASK == "version":
        version(chart, args)


if __name__ == "__main__":
    main()
