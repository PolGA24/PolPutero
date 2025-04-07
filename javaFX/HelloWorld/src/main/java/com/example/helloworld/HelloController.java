package com.example.helloworld;

import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;

public class HelloController {
    @FXML
    private Label welcomeText;

    @FXML
    private TextField n1;

    @FXML
    private TextField n2;

    @FXML
    protected void onHelloButtonClick() {
        try {
            int num1 = Integer.parseInt(n1.getText());
            int num2 = Integer.parseInt(n2.getText());
            int total = num1 + num2;
            welcomeText.setText("Resultat: " + total);
        } catch (NumberFormatException e) {
            welcomeText.setText("Introdueix números vàlids!");
        }
    }
}