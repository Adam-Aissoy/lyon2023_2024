# Nom du compilateur
CXX = g++

# Options de compilation
CXXFLAGS = -std=c++11 -Wall -Wextra

# Nom de l'exécutable
TARGET = mycp

# Liste des fichiers sources
SOURCES = mycp.cpp

# Règle de construction de l'exécutable
$(TARGET): $(SOURCES)
	$(CXX) $(CXXFLAGS) -o $@ $^

# Règle pour nettoyer les fichiers temporaires
clean:
	rm -f $(TARGET)

# Règle par défaut
all: $(TARGET)

# Phony targets (cibles fictives)
.PHONY: all clean
