.PHONY: build dist

install:
	apt install gcc

build: install
	@gcc main.cpp -o out
	@./out

dist: 
	
