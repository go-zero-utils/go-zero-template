
func (m *default{{.upperStartCamelObject}}Model) Update(ctx context.Context, data *{{.upperStartCamelObject}}, tx ...*gorm.DB) error {
    {{if .withCache}}old, err := m.FindOne(ctx, data.{{.upperStartCamelPrimaryKey}})
    if err != nil && err != ErrNotFound {
        return err
    }
    err = m.ExecCtx(ctx, func(conn *gorm.DB) error {
        db := m.GetConn(conn, tx...)
        return db.Save(data).Error
    }, m.getCacheKeys(old)...){{else}}db := m.GetConn(m.conn, tx...)
        err:= db.WithContext(ctx).Save(data).Error{{end}}
    return err
}

func (m *default{{.upperStartCamelObject}}Model) UpdateByFields(ctx context.Context, data *{{.upperStartCamelObject}}, fileds []string, tx ...*gorm.DB) error {
    {{if .withCache}}old, err := m.FindOne(ctx, data.{{.upperStartCamelPrimaryKey}})
    if err != nil && err != ErrNotFound {
        return err
    }
    err = m.ExecCtx(ctx, func(conn *gorm.DB) error {
       	db := m.GetConn(conn, tx...)
        return db.Select(fileds).Save(data).Error
    }, m.getCacheKeys(old)...){{else}}db := m.GetConn(m.conn, tx...)
        err:= db.WithContext(ctx).Select(fileds).Save(data).Error{{end}}
    return err
}

{{if .withCache}}
func (m *default{{.upperStartCamelObject}}Model) getCacheKeys(data *{{.upperStartCamelObject}}) []string {
    if data == nil {
        return []string{}
    }
    {{.keys}}
    cacheKeys := []string{
        {{.keyValues}},
    }
    cacheKeys = append(cacheKeys, m.customCacheKeys(data)...)
    return cacheKeys
}
{{end}}
