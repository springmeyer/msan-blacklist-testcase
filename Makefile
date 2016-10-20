all: test

test:
	clang++ -fsanitize=memory -fsanitize-blacklist=1.blacklist test.cc
	./a.out