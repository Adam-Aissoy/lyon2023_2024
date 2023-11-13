## create make with this command{TableauDynamique.cpp, TableauDynamique.h,ElementTD.cpp, ElementTD.h and main.cpp}
# Makefile

CC = g++
CFLAGS = -Wall

# List of source files
SRCS = TableauDynamique.cpp ElementTD.cpp main.cpp

# List of object files
OBJS = $(SRCS:.cpp=.o)

# Executable name
EXEC = monprog.out

# Main target
$(EXEC): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(EXEC)

# Rule to compile .cpp files to .o files
%.o: %.cpp
	$(CC) $(CFLAGS) -c $< -o $@

# Phony target to clean the project
clean:
	rm -f $(OBJS) $(EXEC)
