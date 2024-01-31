/* je veux creer une fonction somme */
public class test {
    public static void main(String[] args) {
        int a = 5;
        int b = 6;
        int c = somme(a, b);
        System.out.println("la somme de " + a + " et " + b + " est " + c);
    }

    public static int somme(int a, int b) {
        return a + b;
    }
}
