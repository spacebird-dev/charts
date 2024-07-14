HELM_DOCS_TAG := "v1.14.2"

# Generate docs for all charts. Should be run from the root directory
docs-all:
	docker run --rm -v "$$(pwd):/helm-docs" -u $$(id -u) jnorwood/helm-docs:${HELM_DOCS_TAG} --chart-search-root=charts --template-files=./_templates.gotmpl --template-files=README.md.gotmpl

# Generate the docs for just a single chart. should be run from the chart directory
docs:
	docker run --rm -v "$$(pwd):/helm-docs" -v "$$(pwd)/../_templates.gotmpl:/_templates.gotmpl" -u $$(id -u) jnorwood/helm-docs:${HELM_DOCS_TAG} --template-files=/_templates.gotmpl --template-files=README.md.gotmpl
