import "python.pp"
import "nginx.pp"

stage { "pre": before => Stage["main"] }
stage { "last": require => Stage["main"] }

include python
include nginx
