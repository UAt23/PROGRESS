.PHONY: build dist

install:
	apt install g++ -y

build: install
	g++ main.cpp -lstdc++ -o out

create_files_for_packaging:
	mkdir -p hello_1.0.0_amd64
	mkdir -p hello_1.0.0_amd64/DEBIAN
	cp control hello_1.0.0_amd64/DEBIAN/
	mkdir -p hello_1.0.0_amd64/usr/bin
	cp out hello_1.0.0_amd64/usr/bin/
dist: build create_files_for_packaging 
	dpkg-deb -b hello_1.0.0_amd64/
	apt install ./hello_1.0.0_amd64.deb
	out

create_docker_container:
	docker build -t ubuntu .
	docker run --name project1 -d --rm ubuntu  	