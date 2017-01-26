# DcDeps

A simple command line utility for grabbing docker-compose dependencies for given services. Works well with bash, make and other command line tools. 

## Usage

```
dcdeps service-name(s) [--file|-f ~/path/to/docker-compose.yml]
```
Examples:
```
$ dcdeps service-gateway service1 service2 -f ~/wrk/docker-compose.yml
mongodb service3 service0

$ dcdeps service-gateway
mongodb
```

## Advanced usage
You can use it with docker-compose ie. start services related to given one:
```
$ docker-compose up -d $(dcdeps service1)
```

or with make - start docker-based dependencies (or mock them ;) for a given one and run incremental run of a SBT-based scala project(s) in multiple threads:
```
$ make -j2 run P="service-gateway service1"
```
Makefile:
```Makefile
DCDEPS := $(shell command -v dcdeps 2> /dev/null)

.PHONY: run $(R)
run: $(R)
$(R):
ifndef DCDEPS
		@echo "DcDeps not available. Start dependencies manually..."
else

		@docker-compose up -d $(filter-out $(R),$(shell dcdeps $(@)))		
endif
		@sbt "project $(@)" "~re-start --- -Dconfig.resource=dev.conf"
```

## Installation

To install use mix:
```
mix deps.get
mix escript.build
mix escript.install
```
