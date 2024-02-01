CPP_SRC = mandel.cpp display.cpp main.cpp

LDPATH=-L /usr/X11R6/lib/

CXX=g++
LDFLAGS=$(LDPATH) -std=c++11 -lX11 -pthread
CFLAGS=-g -O0 -Wall -Wextra

mandel: $(CPP_SRC) $(wildcard *.h) $(wildcard *.tpp)
	$(CXX) $(CPP_SRC) $(CFLAGS) $(LDFLAGS) -o $@

clean:
	-$(RM) *.o mandel
