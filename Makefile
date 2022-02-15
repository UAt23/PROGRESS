.PHONY: build dist

install:
	apt install g++ -y

build: install
	g++ main.cpp -lstdc++ -o out
	./out

dist: 
	dpkg-deb -b hello_
