function generarTablaMultiplicar() {
    const num = document.getElementById("numTabla").value;
    let tabla = "";
    for (let i = 1; i <= 10; i++) {
        tabla += num + ' x ' + i + ' = ' + (num*i) + '<br>';
    }
    document.getElementById("tabla").innerHTML = tabla;
}
