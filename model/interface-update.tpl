Update(ctx context.Context, {{if .containsIndexCache}}newData{{else}}data{{end}} *{{.upperStartCamelObject}}) error
{{if not .withCache}}UpdateFileds(ctx context.Context, key string, value interface{}, fileds []string, args ...interface{}) error{{end}}
{{if not .withCache}}
Update1(ctx context.Context, {{if .containsIndexCache}}newData{{else}}data{{end}} *{{.upperStartCamelObject}}) error
{{else}}
Update2(ctx context.Context, {{if .containsIndexCache}}newData{{else}}data{{end}} *{{.upperStartCamelObject}}) error
{{end}}