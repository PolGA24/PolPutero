function toggleMenu() {
    let menu = document.getElementById("menu");
    if (menu.style.display === "flex") {
        menu.style.display = "none";
    } else {
        menu.style.display = "flex";
    }
}
window.onload = function() {
    if (!localStorage.getItem("cookiesAceptadas")) {
        document.getElementById("cookieModal").style.display = "block";
    }
};
window.addEventListener('DOMContentLoaded', () => {
    const modoGuardado = localStorage.getItem('modo');
    const boton = document.getElementById("modoBoton");
    if (modoGuardado === 'oscuro') {
        document.body.classList.add("oscuro");
        boton.textContent = "☀️";
    } else {
        document.body.classList.remove("oscuro");
        boton.textContent = "🌙";
    }
});
function aceptarCookies() {
    localStorage.setItem("cookiesAceptadas", true);
    document.getElementById("cookieModal").style.display = "none";
}
function cambiarModoOscuro() {
    document.body.classList.toggle("oscuro");
    const boton = document.getElementById("modoBoton");
    if (document.body.classList.contains("oscuro")) {
        boton.textContent = "☀️";
        localStorage.setItem('modo', 'oscuro');
    } else {
        boton.textContent = "🌙";
        localStorage.setItem('modo', 'claro');
    }
}
