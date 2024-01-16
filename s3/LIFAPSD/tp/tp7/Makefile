CXX = g++
CXXFLAGS = -Wall -fPIE

all: monprog.out

ElementL.o: ElementL.cpp
	$(CXX) $(CXXFLAGS) -c ElementL.cpp -o ElementL.o

ElementTD.o: ElementTD.cpp
	$(CXX) $(CXXFLAGS) -c ElementTD.cpp -o ElementTD.o

Liste.o: Liste.cpp ElementL.o
	$(CXX) $(CXXFLAGS) -c Liste.cpp -o Liste.o

TableauDynamique.o: TableauDynamique.cpp ElementTD.o
	$(CXX) $(CXXFLAGS) -c TableauDynamique.cpp -o TableauDynamique.o

File.o: File.cpp Liste.o
	$(CXX) $(CXXFLAGS) -c File.cpp -o File.o

Pile.o: Pile.cpp TableauDynamique.o
	$(CXX) $(CXXFLAGS) -c Pile.cpp -o Pile.o

main.o: main.cpp
	$(CXX) $(CXXFLAGS) -c main.cpp -o main.o

monprog.out: ElementL.o ElementTD.o Liste.o TableauDynamique.o File.o Pile.o main.o
	$(CXX) $(CXXFLAGS) ElementL.o ElementTD.o Liste.o TableauDynamique.o File.o Pile.o main.o -o monprog.out -no-pie

clean:
	rm -f *.o monprog.out
