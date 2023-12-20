package config

import (
    {{.authImport}}
    
    "{{.rootPkg}}/internal/setup"
)

type Config struct {
	rest.RestConf
    setup.CustomConfig
	{{.auth}}
	{{.jwtTrans}}
}
