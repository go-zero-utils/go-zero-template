package config

import (
    {{.authImport}}
    
    "{{.servicePkg}}/internal/setup"
)

const (
	NACOS_MAIN_DATA_ID = ""
	NACOS_MAIN_GROUP   = ""
)

type Config struct {
	rest.RestConf
    setup.CustomConfig
	{{.auth}}
	{{.jwtTrans}}
}
