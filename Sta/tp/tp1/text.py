import matplotlib.pyplot as plt
import numpy as np

# Générer des données
x = np.linspace(0, 2 * np.pi, 100)
y = np.sin(x)

# Tracer une courbe sinusoïdale
plt.plot(x, y, label='sin(x)')

# Ajouter des labels et un titre
plt.xlabel('Angle (radians)')
plt.ylabel('Sinus')
plt.title('Tracé de la fonction sinus')

# Ajouter une légende
plt.legend()

# Afficher le graphique
plt.show()
