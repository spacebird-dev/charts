{{/*
Expand the name of the chart.
*/}}
{{- define "paperless.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "paperless.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "paperless.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "paperless.labels" -}}
helm.sh/chart: {{ include "paperless.chart" . }}
{{ include "paperless.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "paperless.selectorLabels" -}}
app.kubernetes.io/name: {{ include "paperless.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "paperless.gotenberg.selectorLabels" -}}
app.kubernetes.io/name: {{ include "paperless.name" . }}-gotenberg
app.kubernetes.io/instance: {{ .Release.Name }}-gotenberg
{{- end }}

{{- define "paperless.tika.endpoint" -}}
{{- if .Values.tika.external.endpoint -}}
{{ .Values.tika.external.endpoint }}
{{- else -}}
{{ printf "http://%s:%d" (include "tika-helm.fullname" .Subcharts.tika) .Values.tika.service.port }}
{{- end -}}
{{- end }}
