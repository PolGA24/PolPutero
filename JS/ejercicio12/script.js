function cntTexto() {
    const arr_letras = document.getElementById("texto").value.split("");
    const arr_palabras = document.getElementById("texto").value.split(" ");
    let result = "";

    let arr_letras_repe = [...new Set(arr_letras)];
    for (let i = 0; i < arr_letras_repe.length; i++) {
        let cnt = 0;
        for (let j = 0; j < arr_letras.length; j++) {
            if (arr_letras_repe[i] == arr_letras[j]) {
                cnt++;
            }
        }
        result += "'" + arr_letras_repe[i] + "' : " + cnt + "<br>";
    }

    result += "<br>";

    let arr_palabras_repe = [...new Set(arr_palabras)];
    for (let i = 0; i < arr_palabras_repe.length; i++) {
        let cnt = 0;
        for (let j = 0; j < arr_palabras.length; j++) {
            if (arr_palabras_repe[i] == arr_palabras[j]) {
                cnt++;
            }
        }
        result += "'" + arr_palabras_repe[i] + "' : " + cnt + "<br>";
    }

    document.getElementById("resultado").innerHTML = result;
}