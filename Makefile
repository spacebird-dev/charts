HELM_DOCS_TAG := "v1.14.2"
CHART_TESTING_DOCKER_TAG := "v3.7.1"

all: docs lint

# Generate docs for all charts. Should be run from the root directory
docs:
	docker run --rm -v "$$(pwd):/helm-docs" -u $$(id -u) jnorwood/helm-docs:${HELM_DOCS_TAG} --chart-search-root=charts --template-files=./_templates.gotmpl --template-files=README.md.gotmpl

lint:
	docker run -it --network host --workdir=/data --volume $$(pwd):/data quay.io/helmpack/chart-testing:${CHART_TESTING_DOCKER_TAG} ct lint --config tests/ct.yaml --all
