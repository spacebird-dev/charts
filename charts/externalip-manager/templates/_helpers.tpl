{{/*
Expand the name of the chart.
*/}}
{{- define "externalip-manager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "externalip-manager.fullname" -}}
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
{{- define "externalip-manager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "externalip-manager.labels" -}}
helm.sh/chart: {{ include "externalip-manager.chart" . }}
{{ include "externalip-manager.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "externalip-manager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "externalip-manager.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "externalip-manager.serviceAccountName" -}}
{{- default (include "externalip-manager.fullname" .) .Values.serviceAccount.name }}
{{- end }}

{{/*
Create the name of the clusterRole to use
*/}}
{{- define "externalip-manager.clusterRoleName" -}}
{{- default (include "externalip-manager.fullname" .) .Values.clusterRole.name }}
{{- end }}

{{/*
Create the name of the clusterRole to use
*/}}
{{- define "externalip-manager.clusterRoleBindingName" -}}
{{- default (include "externalip-manager.fullname" .) .Values.clusterRoleBinding.name }}
{{- end }}
