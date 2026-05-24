export SHELL = /usr/bin/env bash -xe

# DO NOT update the variables here!
#
# they only document the default. Add your
# choices in Makefile.local
#
# setting: user that will run agv inside container
export USER=nobody
# setting: dir that will show up inside container
export PATH_CODE:=$(shell pwd -P)/code
# setting: dir that will show as ~/.gemini r/w inside container
export PATH_CONF:=$(shell pwd -P)/settings

export TZ="Etc/UTC"
export LOG_LEVEL=silly

# highlight output from make being verbose vs other commands it calls
export PS4=\[\e[93m\]+MAKE+ \[\e[m\]
-include Makefile.local
#default: clean build
default: all
all: run

build: Dockerfile
	doas docker build --build-arg USER=${USER}  -t myagv .

#${PATH_CONF}:
#	mkdir $@
#run: ${PATH_CONF} ${PATH_CODE}
run:
	doas docker run -it -v "${PATH_CODE}:/home/${USER}/code" -v "${PATH_CONF}:/home/${USER}/.gemini"  myagv

