.PHONY: build dist

install:
	apt install gcc -y

build: install
	@gcc main.cpp -o out
	@./out

dist: 
	
