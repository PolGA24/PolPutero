import java.sql.*;
import java.util.Scanner;

public class Main {
    static String url = "jdbc:mysql://localhost:3306/loginex";
    static String user = "root";
    static String password = "";

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        boolean quit = false;

        while (quit == false ) {
            System.out.println("LOGIN[1]\n" +
                    "SIGNIN[2]");
            int login = sc.nextInt();
            sc.nextLine();

            switch (login) {
                case 1:
                    System.out.println("user name: ");
                    String vUserName = sc.nextLine();
                    System.out.println("password: ");
                    String vPassword = sc.nextLine();

                    if (login(vUserName, vPassword)) {
                        try {
                            Connection conn = DriverManager.getConnection(url, user, password);
                            Statement stmt = conn.createStatement();
                            String sql = "SELECT admin FROM user WHERE UserName = '" + vUserName + "'";
                            ResultSet rs = stmt.executeQuery(sql);
                            boolean isadmin = false;
                            while (rs.next()) {
                                isadmin = rs.getBoolean("admin");
                            }
                            if (isadmin) {
                                menuAdmin(sc);
                            }

                        } catch (SQLException e) {
                            System.out.printf("ERROR: %s\n", e.getMessage());
                        }
                    }

                    sc.nextLine();
                    break;
                case 2:
                    System.out.println("user name: ");
                    vUserName = sc.nextLine();
                    System.out.println("password: ");
                    vPassword = sc.nextLine();

                    signin(vUserName, vPassword);

                    sc.nextLine();
                    break;
                default:
                    quit = true;
                    break;
            }

        }
    }

    public static void crearUsuari() {
        Scanner sc = new Scanner(System.in);
        System.out.printf("Nom del nou usuari: ");
        String nom = sc.nextLine();
        System.out.printf("Contrasenya del nou usuari: ");
        String contrasenya = sc.nextLine();
        System.out.printf("Admin? [S/N]");
        String vadmin = sc.next().toUpperCase();

        if (vadmin.equals("S")) {
            try{
                Connection conn = DriverManager.getConnection(url, user, password);
                Statement stmt = conn.createStatement();
                String sql = "INSERT INTO user (UserName, UserPassword, admin) VALUES ('" + nom + "', '" + contrasenya + "', TRUE)";
                boolean result = stmt.execute(sql);
                System.out.println("Usuari introduit correctament");

                stmt.close();
                conn.close();
            }catch (SQLException e){
                System.out.println("ERROR: " + e.getMessage());
            }
        }else {
            signin(nom, contrasenya);
        }
    }

    public static void veureLlistatUsuaris(){
        try{
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();
            String query = "SELECT * FROM user";
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("UserName");
                String vpassword = rs.getString("UserPassword");
                boolean admin = rs.getBoolean("admin");

                System.out.printf(
                        "ID: %d\t" +
                                "Name: %s\t" +
                                "Password: %s\t" +
                                "Admin: %b\n",
                        id, name, vpassword, admin
                );
            }

            rs.close();
            stmt.close();
            conn.close();
        }catch (SQLException e){
            System.out.println("ERROR: " + e.getMessage());
        }
    }

    public static void modificarUsuari(){
        Scanner sc = new Scanner(System.in);
        System.out.printf("ID del usuari a modificar: ");
        int id = sc.nextInt();
        sc.nextLine();
        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM user WHERE id = " + id + ";";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                String name = rs.getString("UserName");
                String vpassword = rs.getString("UserPassword");
                boolean admin = rs.getBoolean("admin");

                System.out.printf(
                        "ID: %d UserName: %s Password: %s Admin: %b%n",
                        id, name, vpassword, admin
                );
            }
            rs.close();

            System.out.println("Que vols modificar?\n" +
                    "[1] UserName\n" +
                    "[2] Password\n" +
                    "[3] Admin\n" +
                    "[4] Sortir");
            String update = "";
            boolean sortir = false;
            int mod = sc.nextInt();
            sc.nextLine();
            if (mod == 1) {
                System.out.printf("Nou UserName: ");
                String newUserName = sc.nextLine();
                update = "UPDATE user SET UserName = '" + newUserName + "' WHERE id = " + id + ";";
            }else if (mod == 2) {
                System.out.printf("Nou Password: ");
                String newPassword = sc.nextLine();
                update = "UPDATE user SET UserPassword = '" + newPassword + "' WHERE id = " + id + ";";
            }else if (mod == 3) {
                System.out.printf("Es Admin? [S/N]");
                String newAdmin = sc.next().toUpperCase();
                if (newAdmin.equals("S")) {
                    update = "UPDATE user SET admin = TRUE WHERE id = " + id + ";";
                }else{
                    update = "UPDATE user SET admin = FALSE WHERE id = " + id + ";";
                }
            }else {
                sortir = true;
            }

            if (!sortir) {
                boolean result = stmt.execute(update);
                System.out.println("Update realitzat correctament");
            }
            stmt.close();
            conn.close();

        }catch (SQLException e) {
            System.out.printf("ERROR: " + e.getMessage());
        }
    }

    public static void eliminarUsuari(){
        Scanner sc = new Scanner(System.in);
        System.out.printf("ID del usuari a eliminar: ");
        int id = sc.nextInt();
        String delete = "DELETE FROM user WHERE id = " + id + ";";
        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();
            stmt.execute(delete);
            System.out.println("Delete realitzat correctament");
            stmt.close();
            conn.close();
        }catch (SQLException e){
            System.out.println("ERROR: " + e.getMessage());
        }
    }

    public static void menuAdmin(Scanner sc) {
        boolean quit2 = false;
        while (!quit2) {
            System.out.println("HOLA ADMIN\n" +
                    "[1]Crear Usuari\n" +
                    "[2]Veure Llistat d'Usuaris\n" +
                    "[3]Modificar Usuari\n" +
                    "[4]Eliminar Usuari\n" +
                    "[5]Sortir");

            int menu = sc.nextInt();
            sc.nextLine();
            switch (menu) {
                case 1:
                    crearUsuari();
                    break;
                case 2:
                    veureLlistatUsuaris();
                    break;
                case 3:
                    modificarUsuari();
                    break;
                case 4:
                    eliminarUsuari();
                    break;
                default:
                    quit2 = true;
                    break;
            }
        }
    }

    public static boolean login(String vUserName, String vPassword) {
        try{
            Connection conn = DriverManager.getConnection(url, user, password);

            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM user WHERE UserName = '" + vUserName + "' AND UserPassword = '" + vPassword + "'";
            boolean result = stmt.execute(sql);
            if(result) {
                System.out.println("login correcte");
            }else {
                System.out.println("login incorrecte");
            }
            conn.close();
            return result;

        }catch (SQLException e){
            System.out.println("ERROR: " + e.getMessage());
        }
        return false;
    }

    public static void signin(String vUserName, String vPassword) {
        try{
            Connection conn = DriverManager.getConnection(url, user, password);

            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO user (UserName, UserPassword) VALUES ('" + vUserName + "', '" + vPassword + "')";
            boolean result = stmt.execute(sql);
            System.out.println("Registre realitzat correctament");
            conn.close();
        }catch (SQLException e){
            System.out.println("ERROR: " + e.getMessage());
        }
    }
}