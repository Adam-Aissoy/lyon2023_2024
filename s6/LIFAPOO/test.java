// Superclass
class Animal {
    public void makeSound() {
        System.out.println("Some generic sound");
    }
}

// Subclass
class Dog extends Animal {
    // Override the makeSound method
    @Override
    public void makeSound() {
        System.out.println("Woof");
    }
}

public class Main {
    public static void main(String[] args) {
        Animal animal = new Animal();
        animal.makeSound(); // Output: Some generic sound
        
        Dog dog = new Dog();
        dog.makeSound(); // Output: Woof
    }
}
