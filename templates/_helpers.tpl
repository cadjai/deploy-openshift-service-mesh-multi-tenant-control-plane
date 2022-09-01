{{/*
Expand the name of the chart.
*/}}
{{- define "ossm-smcp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ossm-smcp.fullname" -}}
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
{{- define "ossm-smcp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ossm-smcp.labels" -}}
helm.sh/chart: {{ include "ossm-smcp.chart" . }}
{{ include "ossm-smcp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ossm-smcp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ossm-smcp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ossm-smcp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ossm-smcp.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the namespace to use
*/}}
{{- define "ossm-smcp.namespace" -}}
{{- if .Values.namespace.useSuffix }}
{{- print .Values.namespace.name .Values.namespace.suffix -}}
{{- else -}}
{{- printf .Values.namespace.name -}}
{{ end }}
{{- end -}}

{{/*
Create the name of the test namespace to use
*/}}
{{- define "ossm-smcp.testnamespace" -}}
{{- if .Values.testnamespace.useSuffix -}}
{{- print .Values.testnamespace.name .Values.testnamespace.suffix -}}
{{- else -}}
{{- printf .Values.testnamespace.name -}}
{{ end }}
{{- end -}}

{{/*
Create the name of the test namespace roll member to use
*/}}
{{- define "ossm-smcp.tnsrollmember" -}}
{{- if .Values.testnamespace.useSuffix -}}
{{- print .Values.testnamespace.name .Values.testnamespace.suffix -}}
{{- else -}}
{{- printf .Values.testnamespace.name -}}
{{ end }}
{{- end -}}
