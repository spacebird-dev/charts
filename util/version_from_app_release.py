#!/usr/bin/env python3

#!/usr/bin/env python3
"""version_from_app_release

Updates a Helm charts version fields based upon a new application version.

Takes a path to a helm chart and a semver-formatted application version.

- The appVersion field will be set to the provided version
- The version field will be bumped depending on whether the application is a patch, minor or major release.

Outputs "patch", "minor" or "major", depending on the app release size
"""

import argparse
import os
from pathlib import Path

from semver import VersionInfo
import yaml


def main():
    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("CHART_DIRECTORY",help="Path to the chart directory", default=os.getcwd())
    parser.add_argument("VERSION_BUMP", help="Version to bump the appVersion to")
    parser.add_argument("--output-only", action="store_true", help="Do not update Chart.yaml, only output the version bump size")
    args = parser.parse_args()

    chart_dir = Path(args.CHART_DIRECTORY)

    with open(chart_dir / "Chart.yaml", encoding="utf-8") as f:
        chart_data = yaml.safe_load(f)

    current_chart_ver = VersionInfo.parse(str(chart_data["version"]))
    current_chart_app = VersionInfo.parse(str(chart_data["appVersion"]))
    bump_version = VersionInfo.parse(args.VERSION_BUMP)

    if current_chart_app > bump_version:
        raise ValueError("New appVersion is lower than current version, aborting")
    if bump_version.prerelease:
        raise ValueError("New appVersion is a pre-release, aborting")

    if current_chart_app.major < bump_version.major:
        print("major")
        new_chart_ver = current_chart_ver.next_version("major")
    elif current_chart_app.minor < bump_version.minor:
        print("minor")
        new_chart_ver = current_chart_ver.next_version("minor")
    elif current_chart_app.patch < bump_version.patch:
        print("patch")
        new_chart_ver = current_chart_ver.next_version("patch")
    else:
        raise ValueError(f"Could not determine version difference: {current_chart_app} vs {bump_version}")

    chart_data["version"] = str(new_chart_ver)
    chart_data["appVersion"] = str(bump_version)

    if not args.output_only:
        with open(chart_dir / "Chart.yaml", "w", encoding="utf-8") as f:
            yaml.dump(chart_data, f, allow_unicode=True)

if __name__ == "__main__":
    main()
