
func (m *default{{.upperStartCamelObject}}Model) Delete(ctx context.Context, {{.lowerStartCamelPrimaryKey}} {{.dataType}}, tx ...*gorm.DB) error {
	{{if .withCache}}data, err:=m.FindOne(ctx, {{.lowerStartCamelPrimaryKey}})
	if err!=nil{
        if errors.Is(err, ErrNotFound) {
                return nil
        }
		return err
	}
	 err = m.ExecCtx(ctx, func(conn *gorm.DB) error {
        db := m.GetConn(conn,  tx...).Scopes(m.scopes())
        return db.Delete(&{{.upperStartCamelObject}}{}, {{.lowerStartCamelPrimaryKey}}).Error
	}, m.getCacheKeys(data)...){{else}} db := m.GetConn(m.conn, tx...)
        err:= db.WithContext(ctx).Delete(&{{.upperStartCamelObject}}{}, {{.lowerStartCamelPrimaryKey}}).Error
	{{end}}
	return err
}

func (m *default{{.upperStartCamelObject}}Model) Transaction(ctx context.Context, fn func(db *gorm.DB) error) error {
    {{if .withCache}}return m.TransactCtx(ctx, fn){{else}} return m.conn.WithContext(ctx).Transaction(fn){{end}}
}

func (m *default{{.upperStartCamelObject}}Model) GetConn(conn *gorm.DB, tx ...*gorm.DB) *gorm.DB {
    if len(tx) > 0 {
        return tx[0]
    }
    return conn
}

func (m *default{{.upperStartCamelObject}}Model) scopes() func(db *gorm.DB) *gorm.DB {
    return func(db *gorm.DB) *gorm.DB {
        return db.Table(m.table)
    }
}
