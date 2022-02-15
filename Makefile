.PHONY: build dist

install:
	apt install gcc -y

build: install
	gcc main.cpp -lstdc++ -o out
	./out

dist: 
	dpkg-deb -b hello_
