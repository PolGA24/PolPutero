/*
1. La Serialització d'Objectes Màgica 🔮
Enunciat: Defineix una classe Java amb atributs i crea un programa que converteixi objectes d'aquesta classe en un fitxer binari.
Repte Extra: Desxifra el fitxer binari amb un altre programa i mostra els atributs dels objectes.
 */

import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
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

            try {
                op = sc.nextInt();
                System.out.println();
                switch (op) {
                    case 1:
                        personajes.add(crearPersonaje());
                        write(personajes.getLast());
                        break;
                    case 2:
                        salir = true;
                        break;
                    default:
                        System.out.println("Opcion no valida");
                        break;
                }
            } catch (Exception e) {
                System.out.println("Opcion no valida");
            }

            System.out.println();
        }
    }
    public static Personaje crearPersonaje() {
        Scanner sc = new Scanner(System.in);

        System.out.printf("Ingrese nombre: ");
        String nombre = sc.nextLine();
        System.out.printf("Ingrese edad: ");
        int edad = sc.nextInt();
        System.out.printf("Ingrese email: ");
        sc.nextLine();
        String email = sc.nextLine();

        Personaje personaje = new Personaje(nombre, edad, email);
        System.out.println("Personaje creado!");
        return personaje;
    }
    public static void write(Personaje personaje) {
        FileOutputStream fileOut = null;
        DataOutputStream output = null;

        try {
            fileOut = new FileOutputStream("personaje.data");
            output = new DataOutputStream(fileOut);

            output.writeUTF(personaje.toString());
        } catch (IOException ioe) {
            System.out.printf("ERROR: " + ioe.getMessage());
        } catch (Exception e) {
            System.out.printf("ERROR: " + e.getMessage());
        } finally {
            try {
                output.close();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            try {
                fileOut.close();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }
}