Update(ctx context.Context, data *{{.upperStartCamelObject}}, tx ...*gorm.DB) error
UpdateByFields(ctx context.Context, data *{{.upperStartCamelObject}}, fields []string, tx ...*gorm.DB) error