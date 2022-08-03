IMAGE_NAME = devops-docker/shiv-centos8
MAKE_COMMON ?= ../makefile-common
include ${MAKE_COMMON}/docker.mk
include ${MAKE_COMMON}/common.mk

$(TARGET)/makefile-common : 
		@echo "Downloading jenkins war file"
		cp -r ${MAKE_COMMON} $(TARGET)
		
prepare : $(TARGET)/makefile-common