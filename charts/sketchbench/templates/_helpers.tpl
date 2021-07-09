{{/*
Expand the name of the chart.
*/}}
{{- define "sketchbench.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sketchbench.fullname" -}}
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
{{- define "sketchbench.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sketchbench.labels" -}}
helm.sh/chart: {{ include "sketchbench.chart" . }}
{{ include "sketchbench.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sketchbench.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sketchbench.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sketchbench.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "sketchbench.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
  Kafdrop Configuration
  Override Kafdrop broker connections rendering to include .Release.Name; based on:
  https://github.com/helm/helm/issues/3558#issuecomment-369008047
*/}}
{{- define "kafdrop.connections" -}}
    {{- $connections := $.Values.config.kafka.connections -}}
    {{- if kindIs "slice" $.Values.config.kafka.connections }}
        {{- $connections = ($.Values.config.kafka.connections | join ", ") -}}
    {{- end }}
    {{- printf "%s-%s" .Release.Name $connections -}}
{{- end }}
