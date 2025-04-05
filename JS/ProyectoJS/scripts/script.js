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

function aceptarCookies() {
    localStorage.setItem("cookiesAceptadas", true);
    document.getElementById("cookieModal").style.display = "none";
}
function cambiarModo() {
    document.body.classList.toggle("oscuro");
    const boton = document.getElementById("modoBoton");
    if (document.body.classList.contains("oscuro")) {
        boton.textContent = "☀️ Modo Claro";
    } else {
        boton.textContent = "🌙 Modo Oscuro";
    }
}
