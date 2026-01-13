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
{{- define "paperless.commonLabels" -}}
helm.sh/chart: {{ include "paperless.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{- define "paperless.labels" -}}
{{ include "paperless.commonLabels" . }}
{{ include "paperless.selectorLabels" . }}
{{- end }}
{{- define "paperless.redis.labels" -}}
{{ include "paperless.commonLabels" . }}
{{ include "paperless.redis.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "paperless.commonSelectorLabels" -}}
app.kubernetes.io/name: {{ include "paperless.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "paperless.selectorLabels" -}}
{{ include "paperless.commonSelectorLabels" . }}
app.kubernetes.io/component: "paperless"
{{- end }}
{{- define "paperless.redis.selectorLabels" -}}
{{ include "paperless.commonSelectorLabels" . }}
app.kubernetes.io/component: "redis"
{{- end -}}
