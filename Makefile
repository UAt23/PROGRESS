.PHONY: build dist

install:
	apt install g++ -y

build: install
	g++ main.cpp -lstdc++ -o out

create_files_for_packaging:
	[-d hello_1.0.0_amd64] || mkdir hello_1.0.0_amd64
	cd hello_1.0.0_amd64/
	mkdir DEBIAN
	cp ../control DEBIAN/
	mkdir -p usr/bin
	cp ../out usr/bin/
	cd ..
dist: build create_files_for_packaging 
	dpkg-deb -b hello_1.0.0_amd64/
	apt install ./hello_1.0.0_amd64.deb
	out