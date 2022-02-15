.PHONY: build dist

install:
	apt install g++ -y

build: install
	g++ main.cpp -lstdc++ -o out

create_files_for_packaging:
	mkdir hello_1.0.0_amd64
	cd hello_1.0.0_amd64/
	mkdir DEBIAN
	cat <<EOT >> control
	Package: hello
	Version: 1.0.0-1
	Architecture: amd64
	Maintainer: Ugur Alp <uguralp9948@gmail.com>
	Description: hello world as debian package
	EOT
	mkdir -p usr/bin
	cp ../out usr/bin/
	cd ..
dist: create_files_for_packaging
	dpkg-deb -b hello_1.0.0_amd64/
	apt install ./hello_1.0.0_amd64.deb
	out