/*
Fonction estOuvrante(caractere) : booléen
    Retourne vrai si le caractère est '(' ou '[', faux sinon

Fonction estFermante(caractere) : booléen
    Retourne vrai si le caractère est ')' ou ']', faux sinon

Fonction correspond(ouvrante, fermante) : booléen
    Retourne vrai si ouvrante est '(' et fermante est ')', ou si ouvrante est '[' et fermante est ']', faux sinon

Fonction valide(expression : chaîne de caractères) : booléen
    initialiser une pile vide

    Pour chaque caractère dans l'expression
        Si le caractère est une parenthèse ouvrante '(' ou '['
            Empiler le caractère sur la pile
        Sinon, si le caractère est une parenthèse fermante ')' ou ']'
            Si la pile est vide
                Retourner faux  // Il n'y a pas de correspondance pour cette parenthèse fermante
            Sinon
                Dépiler un élément de la pile
                Si l'élément dépile est une parenthèse ouvrante correspondante
                    Continuer la boucle
                Sinon
                    Retourner faux  // Il n'y a pas de correspondance pour cette parenthèse fermante

    Si la pile n'est pas vide à la fin
        Retourner faux  // Il y a des parenthèses ouvrantes non fermées

    Retourner vrai  // L'expression est valide
*/

