Update(ctx context.Context, {{if .containsIndexCache}}newData{{else}}data{{end}} *{{.upperStartCamelObject}}) error
{{if not .withCache}}UpdateFileds(ctx context.Context, key string, value interface{}, fileds []string, args ...interface{}) error{{end}}
{{if not .withCache}}
1
{{else}}
2
{{end}}