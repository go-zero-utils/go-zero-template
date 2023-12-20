package main

import (
	"fmt"
    
    "{{.projectPkg}}/internal/i18n"
    "{{.projectPkg}}/internal/initialize"

	{{.importPackages}}
)


func main() {
	var c config.Config
    err := initialize.InitConfigFromNacos(config.NACOS_MAIN_DATA_ID, config.NACOS_MAIN_GROUP, func(content string) error {
		return conf.LoadConfigFromYamlBytes([]byte(content), &c)
	})
	if err != nil {
		panic(fmt.Errorf("initialize.InitConfigFromNacos err: %s", err.Error()))
	}

    err = i18n.Load(c.Language)
	if err != nil {
		panic(fmt.Errorf("i18n.Load err: %s", err.Error()))
	}

	server := rest.MustNewServer(c.RestConf)
	defer server.Stop()

	ctx := svc.NewServiceContext(c)
	handler.RegisterHandlers(server, ctx)

	fmt.Printf("Starting server at %s:%d...\n", c.Host, c.Port)
	server.Start()
}
