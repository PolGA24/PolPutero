/*
1. La Serialització d'Objectes Màgica 🔮
Enunciat: Defineix una classe Java amb atributs i crea un programa que converteixi objectes d'aquesta classe en un fitxer binari.
Repte Extra: Desxifra el fitxer binari amb un altre programa i mostra els atributs dels objectes.
 */

import java.util.ArrayList;
import java.util.Scanner;
import java.io.FileOutputStream;
import java.io.ObjectOutputStream;
import java.io.IOException;
import java.io.FileInputStream;
import java.io.ObjectInputStream;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<Personaje> personajes = new ArrayList();
        boolean salir = false;

        while (!salir) {
            int op;
            System.out.println("SELECCIONE OPCION");
            System.out.println("1. Agregar personaje");
            System.out.println("2. Ver ultimo personaje");
            System.out.println("3. Salir");
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
                        read();
                        break;
                    case 3:
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
    public static void read() {
        try (FileInputStream fileIn = new FileInputStream("personaje.data");
             ObjectInputStream objectIn = new ObjectInputStream(fileIn)) {

            Personaje personaje = (Personaje) objectIn.readObject();
            System.out.println("Nombre: " + personaje.getNombre());
            System.out.println("Edad: " + personaje.getEdad());
            System.out.println("Correo: " + personaje.getCorreo());
        } catch (IOException | ClassNotFoundException e) {
            System.out.println("Error al leer el objeto: " + e.getMessage());
        }
    }
    public static void write(Personaje personaje) {
        try (FileOutputStream fileOut = new FileOutputStream("personaje.data");
             ObjectOutputStream objectOut = new ObjectOutputStream(fileOut)) {

            objectOut.writeObject(personaje);
            System.out.println("Objeto guardado correctamente.");

        } catch (IOException e) {
            System.out.println("Error al guardar el objeto: " + e.getMessage());
        }
    }
}
