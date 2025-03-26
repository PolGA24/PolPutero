function obtenerFactorial() {
    const num = document.getElementById("numFactorial").value;
    let factorial = 1;
    for (let i = 1; i <= num; i++) {
        factorial *= i;
    }
    document.getElementById("factorial").innerHTML = num + '! = ' + factorial;
}
