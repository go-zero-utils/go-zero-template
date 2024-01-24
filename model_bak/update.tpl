func (m *default{{.upperStartCamelObject}}Model) Update(ctx context.Context, {{if .containsIndexCache}}newData{{else}}data{{end}} *{{.upperStartCamelObject}}) error {
	{{if .withCache}}{{if .containsIndexCache}}data, err:=m.FindOne(ctx, newData.{{.upperStartCamelPrimaryKey}})
	if err!=nil{
		return err
	}

{{end}}	{{.keys}}
    _, {{if .containsIndexCache}}err{{else}}err:{{end}}= m.ExecCtx(ctx, func(ctx context.Context, conn sqlx.SqlConn) (result sql.Result, err error) {
		query := fmt.Sprintf("update %s set %s where {{.originalPrimaryKey}} = {{if .postgreSql}}$1{{else}}?{{end}}", m.table, {{.lowerStartCamelObject}}RowsWithPlaceHolder)
		return GetConn(ctx, conn).ExecCtx(ctx, query, {{.expressionValues}})
	}, {{.keyValues}}){{else}}query := fmt.Sprintf("update %s set %s where {{.originalPrimaryKey}} = {{if .postgreSql}}$1{{else}}?{{end}}", m.table, {{.lowerStartCamelObject}}RowsWithPlaceHolder)
    _,err:= GetConn(ctx, m.conn).ExecCtx(ctx, query, {{.expressionValues}}){{end}}
	return err
}

// update some fileds
//  exec update table set $fileds=$args where $key = $value
func (m *default{{.upperStartCamelObject}}Model) UpdateFileds(ctx context.Context, key string, value interface{}, fileds []string, args []interface{}) error {
    {{if .withCache}}return nil{{else}}if len(fileds) != len(args) {
        return fmt.Errorf("fileds: %v length not eq args: %v length", fileds, args)
    }
    query := fmt.Sprintf("update %s set %s where `%s` = {{if .postgreSql}}$1{{else}}?{{end}}", m.table, strings.Join(fileds, "={{if .postgreSql}}$1{{else}}?{{end}},") + "={{if .postgreSql}}$1{{else}}?{{end}}", key)
    args = append(args, value)
	_, err := GetConn(ctx, m.conn).ExecCtx(ctx, query, args...)
	return err{{end}}
}
