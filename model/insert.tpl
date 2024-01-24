
func (m *default{{.upperStartCamelObject}}Model) Insert(ctx context.Context, data *{{.upperStartCamelObject}}, tx ...*gorm.DB) error {
	{{if .withCache}}
    err := m.ExecCtx(ctx, func(conn *gorm.DB) error {
		db := m.GetConn(conn, tx...)
        return db.Save(&data).Error
	}, m.getCacheKeys(data)...){{else}}db := m.GetConn(m.conn, tx...)
        err:= db.WithContext(ctx).Save(&data).Error{{end}}
	return err
}
