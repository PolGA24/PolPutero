// SISTEMA MENU DESPLEGABLE
function toggleMenu() {
    let menu = document.getElementById("menu");
    if (menu.style.display === "flex") {
        menu.style.display = "none";
    } else {
        menu.style.display = "flex";
    }
}
// FIN SISTEMA MENU DESPLEGABLE

// SISTEMA DE CARGA DE COOKIES
window.onload = function() {
    if (!localStorage.getItem("cookiesAceptadas")) {
        document.getElementById("cookieModal").style.display = "block";
    }
};
// FIN SISTEMA DE CARGA DE COOKIES

// SISTEMA DE COOKIES
function aceptarCookies() {
    localStorage.setItem("cookiesAceptadas", true);
    document.getElementById("cookieModal").style.display = "none";
}
// FIN SISTEMA DE COOKIES

// SISTEMA DE MODO CLARO/OSCURO
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
window.addEventListener('DOMContentLoaded', () => { // almacenamiento de ultimo modo
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
// FIN SISTEMA DE MODO CLARO/OSCURO
