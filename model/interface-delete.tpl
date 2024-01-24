Delete(ctx context.Context, {{.lowerStartCamelPrimaryKey}} {{.dataType}}, tx ...*gorm.DB) error
Transaction(ctx context.Context, fn func(db *gorm.DB) error) error