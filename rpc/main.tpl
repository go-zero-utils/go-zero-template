package main

import (
	"fmt"

    "{{.projectPkg}}/internal/initialize"

	{{.imports}}
	"github.com/zeromicro/go-zero/core/conf"
	"github.com/zeromicro/go-zero/core/service"
	"github.com/zeromicro/go-zero/zrpc"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {

	var c config.Config
    err := initialize.InitConfigFromNacos(config.NACOS_MAIN_DATA_ID, config.NACOS_MAIN_GROUP, func(content string) error {
		return conf.LoadConfigFromYamlBytes([]byte(content), &c)
	})
	if err != nil {
		panic(fmt.Errorf("initialize.InitConfigFromNacos err: %s", err.Error()))
	}

	ctx := svc.NewServiceContext(c)

	s := zrpc.MustNewServer(c.RpcServerConf, func(grpcServer *grpc.Server) {
{{range .serviceNames}}       {{.Pkg}}.Register{{.Service}}Server(grpcServer, {{.ServerPkg}}.New{{.Service}}Server(ctx))
{{end}}
		if c.Mode == service.DevMode || c.Mode == service.TestMode {
			reflection.Register(grpcServer)
		}
	})
	defer s.Stop()

	err = initialize.RegisterGrpcSerivceFromNacos(c.Name, c.ListenOn)
	if err != nil {
		panic(fmt.Errorf("initialize.RegisterGrpcSerivceFromNacos name: %s, listenOn: %s, err: %s", c.Name, c.ListenOn, err.Error()))
	}

	fmt.Printf("Starting rpc server at %s...\n", c.ListenOn)
	s.Start()
}
