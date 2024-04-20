package VueControleur;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
/* Add Adam Aysoy */
public class Scores {
    private static final String FILE_PATH = "scores.txt";

    private List<Integer> scores;

    public Scores() {
        scores = new ArrayList<>();
    }

    public void ajouterScore(int score) {
        scores.add(score);
    }

    public void sauvegarderScores() {
        try (PrintWriter writer = new PrintWriter(new FileWriter(FILE_PATH))) {
            for (int score : scores) {
                writer.println(score);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void chargerScores() {
        scores.clear();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                scores.add(Integer.parseInt(line));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<Integer> getScores() {
        return scores;
    }
}
