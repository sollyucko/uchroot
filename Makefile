# Requirements (based on ubuntu 16.04)
# apt-get install
#		python-pip
#		clang
#   clang-format
#   cmake
#   gcc
#   g++
#   gnuradio-dev
#   libcurl4-openssl-dev
#   libfuse-dev
#   libgoogle-glog-dev
#   libmagic-dev
#   libudev-dev
#   libvulkan-dev
#   libx11-xcb-dev
#   ninja-build
#
# pip install --upgrade pip
# pip install --user
# 	cpplint
#   autopep8
#   file-magic
#   flask
#   oauth2client
#   pygerrit2
#   pylint
#   recommonmark
#   sphinx
#   sqlalchemy

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

export PYTHONPATH=$(current_dir)

% : .build/cmake_clang/Makefile \
    .build/cmake_gnu/Makefile
	@echo ""
	@echo "clang-build"
	@echo "-----------"
	cd .build/cmake_clang && env -u MAKELEVEL $(MAKE) $@

	@echo ""
	@echo "GNU-build"
	@echo "-----------"
	cd .build/cmake_gnu && env -u MAKELEVEL $(MAKE) $@

all:

test: all



.build/cmake_clang/Makefile:
	@echo ""
	@echo "Configuring clang cmake Build"
	mkdir -p .build/cmake_clang
	cd .build/cmake_clang \
    && env CC=clang CXX=clang++ cmake -DCMAKE_BUILD_TYPE=Debug ../../
	touch .build/cmake_clang/CMakeCache.txt

.build/cmake_gnu/Makefile:
	@echo ""
	@echo "Configuring GNU cmake Build"
	mkdir -p .build/cmake_gnu
	cd .build/cmake_gnu \
    && env cmake -DCMAKE_BUILD_TYPE=Debug ../../
	touch .build/cmake_gnu/CMakeCache.txt
