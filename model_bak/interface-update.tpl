Update(ctx context.Context, {{if .containsIndexCache}}newData{{else}}data{{end}} *{{.upperStartCamelObject}}) error
UpdateFileds(ctx context.Context, key string, value interface{}, fileds []string, args []interface{}) error