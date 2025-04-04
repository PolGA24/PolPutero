import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Scanner;


public class Main {
    public static void main(String[] args) {
        File file = new File("tasques.txt");

        boolean continuar = true;
        while (continuar) {
            System.out.println("\nQue vols fer?" +
                    "\n [1] Veure tasques" +
                    "\n [2] Afegir tasca" +
                    "\n [3] Sortir");
            Scanner sc = new Scanner(System.in);
            int opcio = sc.nextInt();
            switch (opcio) {
                case 1:
                    llegirTasques(file);
                    break;
                case 2:
                    afegirTasca(file);
                    break;
                case 3:
                    continuar = false;
                    break;
                default:
                    System.out.println("Opcio invalida");
            }
        }
    }

    public static void afegirTasca(File file) {
        try {
            Scanner sc = new Scanner(System.in);
            FileOutputStream fos = new FileOutputStream(file, true);

            System.out.println("Escriu la tasca a afegir:");
            String novaTasca = "\n" + sc.nextLine();

            fos.write(novaTasca.getBytes());
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static void llegirTasques(File file) {
        try {
            Scanner sc = new Scanner(file);
            while (sc.hasNextLine()) {
                System.out.println(sc.nextLine());
            }
            sc.close();
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}