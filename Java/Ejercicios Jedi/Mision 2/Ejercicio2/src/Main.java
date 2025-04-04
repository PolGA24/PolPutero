/*
2. L'Editor d'Imatges RAW del Mestre Pixel 🎨
Enunciat: Desenvolupa un programa que llegeixi fitxers d'imatge RAW i realitzi operacions com invertir colors o aplicar filtres.
Repte Épic: Desa el resultat en un nou fitxer binari.
 */

import javax.imageio.IIOException;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.awt.Color;
import java.io.File;
import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        try {
            File file = new File("images.png");
            BufferedImage img = ImageIO.read(file);

            BufferedImage colorinvertido = invertirColor(img);
            ImageIO.write(colorinvertido, "png", new File("images_invertida.png"));

            BufferedImage escalagrises = escalaGrises(img);
            ImageIO.write(escalagrises, "png", new File("images_gris.png"));

            System.out.println("Proceso completado");
        } catch (IIOException iioe) {
            System.err.println("ERROR: " + iioe.getMessage());
        } catch (IOException ioe) {
            System.err.println("ERROR: " + ioe.getMessage());
        }
    }
    public static BufferedImage invertirColor(BufferedImage img) {
        BufferedImage output = new BufferedImage(img.getWidth(), img.getHeight(), img.getType());
        for (int y = 0; y < img.getHeight(); y++) {
            for (int x = 0; x < img.getWidth(); x++) {
                Color c = new Color(img.getRGB(x, y));
                Color invertido = new Color(255 - c.getRed(), 255 - c.getGreen(), 255 - c.getBlue());
                output.setRGB(x, y, invertido.getRGB());
            }
        }
        return output;
    }
    public static BufferedImage escalaGrises(BufferedImage img) {
        BufferedImage output = new BufferedImage(img.getWidth(), img.getHeight(), img.getType());
        for (int y = 0; y < img.getHeight(); y++) {
            for (int x = 0; x < img.getWidth(); x++) {
                Color c = new Color(img.getRGB(x, y));
                int gris = (int)(0.3 * c.getRed() + 0.59 * c.getGreen() + 0.11 * c.getBlue());
                Color escalagrises = new Color(gris, gris, gris);
                output.setRGB(x, y, escalagrises.getRGB());
            }
        }
        return output;
    }
}
