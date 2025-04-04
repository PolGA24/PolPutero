/*
1. La Serialització d'Objectes Màgica 🔮
Enunciat: Defineix una classe Java amb atributs i crea un programa que converteixi objectes d'aquesta classe en un fitxer binari.
Repte Extra: Desxifra el fitxer binari amb un altre programa i mostra els atributs dels objectes.
 */

import java.io.DataOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<Personaje> personajes = new ArrayList();
        boolean salir = false;

        while (!salir) {
            int op;
            System.out.println("SELECCIONE OPCION");
            System.out.println("1. Agregar personaje");
            System.out.println("2. Salir");
            System.out.printf(">");
            op = sc.nextInt();

            switch (op) {
                case 1:
                    personajes.add(crearPersonaje());
                    break;
            }
        }
    }
    public static Personaje crearPersonaje() {
        Scanner sc = new Scanner(System.in);

        System.out.printf("Ingrese nombre: ");
        String nombre = sc.nextLine();
        System.out.printf("Ingrese edad: ");
        int edad = sc.nextInt();
        System.out.printf("Ingrese email: ");
        String email = sc.nextLine();

        Personaje personaje = new Personaje(nombre, edad, email);
        return personaje;
    }
    public static void write(Personaje personaje) throws FileNotFoundException {
        FileOutputStream fileOut = new FileOutputStream("personaje.data");
        DataOutputStream output = new DataOutputStream(fileOut);

    }
}