package main

import (
	"fmt"
    "{{.projectPkg}}/internal/initialize"
	{{.importPackages}}
)


func main() {

	var c config.Config
    err := initialize.InitConfigFromNacos(func(content string) error {
		return conf.LoadConfigFromYamlBytes([]byte(content), &c)
	})
	if err != nil {
		panic(fmt.Errorf("initialize.InitConfigFromNacos err: %s", err.Error()))
	}

	server := rest.MustNewServer(c.RestConf)
	defer server.Stop()

	ctx := svc.NewServiceContext(c)
	handler.RegisterHandlers(server, ctx)

	fmt.Printf("Starting server at %s:%d...\n", c.Host, c.Port)
	server.Start()
}
