all: test

test:
	clang++ -fsanitize=address -fsanitize-blacklist=1.blacklist test.cc
	./a.out