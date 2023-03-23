CC=g++
CFLAGS=-Wall -fopenmp

all: reduction

reduction: reduction.cpp
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f reduction