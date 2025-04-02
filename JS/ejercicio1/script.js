function obtenerTiempo(op) {
    const hoy = new Date();
    switch (op) {
        case 1:
            const mili = hoy.getTime();
            console.log(mili);
            document.getElementById("text").textContent = mili;
            break;
        case 2:
            let dia = hoy.getDay().toString().padStart(2, "0");
            let mes = hoy.getMonth().toString().padStart(2, "0");
            let ano = hoy.getFullYear().toString().padStart(2, "0");
            const fecha = dia + ':' + mes + ':' + ano;
            console.log(fecha);
            document.getElementById("text").textContent = fecha;
            break;
        case 3:
            let hora = hoy.getHours().toString().padStart(2, "0");
            let minuto = hoy.getMinutes().toString().padStart(2, "0");
            let segundo = hoy.getSeconds().toString().padStart(2, "0");
            const tiempo = hora + ':' + minuto + ':' + segundo;
            console.log(tiempo);
            document.getElementById("text").textContent = tiempo;
            break;
    }
}
