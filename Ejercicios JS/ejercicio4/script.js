function operacionMatematica() {
    const formData = new FormData(document.getElementById("operacion"));
    const data = Object.fromEntries(formData);
    let result;
    let num1 = Number(data.numero1);
    let num2 = Number(data.numero2);
    
    switch (data.opcion) {
        case "suma":
            result = num1 + ' + ' + num2 + ' = ' + (num1+num2);
            break;
        case "resta":
            result = num1 + ' - ' + num2 + ' = ' + (num1-num2);
            break;
        case "multi":
            result = num1 + ' * ' + num2 + ' = ' + (num1*num2);
            break;
        case "divi":
            if (num2 == 0) {
                result = "ERROR: operación no válida"
            } else {
                result = num1 + ' / ' + num2 + ' = ' + (num1/num2);
            }
            break;
    }
    document.getElementById("resultado").innerHTML = result;
}
