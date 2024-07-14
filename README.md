# charts

Helm Charts for Spacebird projects, as well as other applications.

Please see the individual chart directories for installation instructions.

To add this chart repository to your helm configuration, run:

`helm repo add spacebird https://charts.spacebird.dev`

# Contributing

Contributions to these charts are always welcome!
For small bugfixes or other additions, feel free to open a PR directly!
For larger changes, you may first want to open an issue for comments.

After making changes to a chart, please regenerate the docs by running `make docs` in the chart directory.
This requires docker.
You can also use a manual install of [`helm-docs`](https://github.com/norwoodj/helm-docs), see the Makefile for the required command.
