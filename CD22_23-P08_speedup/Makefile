CC=g++
CFLAGS=-Wall -fopenmp -std=c++11

all: reduction

reduction: reduction.cpp
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f reduction
