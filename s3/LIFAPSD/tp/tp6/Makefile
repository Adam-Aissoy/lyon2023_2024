# Makefile

CC = g++
CFLAGS = -Wall -fPIE
LDFLAGS = -no-pie

# Liste des fichiers source
SRCS = Liste.cpp ElementL.cpp main.cpp

# Liste des fichiers objets
OBJS = $(SRCS:.cpp=.o)

# Nom de l'exécutable
EXEC = monprog.out

# Cible principale
$(EXEC): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(EXEC) $(LDFLAGS)

# Règle pour compiler les fichiers .cpp en fichiers .o
%.o: %.cpp
	$(CC) $(CFLAGS) -c $< -o $@

# Cible factice pour nettoyer le projet
clean:
	rm -f $(OBJS) $(EXEC)
