package config

import "github.com/zeromicro/go-zero/zrpc"

const (
	NACOS_MAIN_DATA_ID = ""
	NACOS_MAIN_GROUP   = ""
)

type Config struct {
	zrpc.RpcServerConf
}
