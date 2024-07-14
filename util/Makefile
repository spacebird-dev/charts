HELM_DOCS_TAG := "v1.14.2"

docs:
	docker run --rm -v "$$(pwd):/helm-docs" -v "$$(pwd)/../_templates.gotmpl:/_templates.gotmpl" -u $$(id -u) jnorwood/helm-docs:${HELM_DOCS_TAG} --template-files=/_templates.gotmpl --template-files=README.md.gotmpl
