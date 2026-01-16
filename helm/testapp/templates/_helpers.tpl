{{- define "testapp.name" -}}
testapp
{{- end }}

{{- define "testapp.fullname" -}}
{{ include "testapp.name" . }}-{{ .Release.Name }}
{{- end }}
