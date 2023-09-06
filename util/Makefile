SHELL := /bin/bash

venv:
	python3 -m venv .venv
	source .venv/bin/activate && pip install -r ../../util/requirements.txt --quiet

set-app-version: venv
	source .venv/bin/activate && ../../util/set_chart_version.py ./ app $(version)

set-chart-version: venv
	source .venv/bin/activate && ../../util/set_chart_version.py ./ chart $(version)

get-version-bump-size: venv
	source .venv/bin/activate && ../../util/version_from_app_release.py --output-only ./ $(version)

version-from-app-release: venv
	source .venv/bin/activate && ../../util/version_from_app_release.py ./ $(version)

docs: venv
	source .venv/bin/activate && frigate gen . > README.md
