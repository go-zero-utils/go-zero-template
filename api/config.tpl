package config

import (
    {{.authImport}}
    
    "{{.servicePkg}}/internal/setup"
)

type Config struct {
	rest.RestConf
    setup.CustomConfig
	{{.auth}}
	{{.jwtTrans}}
}
