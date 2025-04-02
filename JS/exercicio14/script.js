function buscarPais() {
    const nombrePais = document.getElementById('pais').value.trim();
    if (!nombrePais) {
        alert('Por favor, ingresa un nombre de país.');
        return;
    }
    
    fetch(`https://restcountries.com/v3.1/name/${nombrePais}`)
        .then(response => response.json())
        .then(data => {
            if (data.status === 404) {
                document.getElementById('info').innerHTML = '<p>País no encontrado.</p>';
                return;
            }
            const pais = data[0];
            const nombre = pais.name.common;
            const bandera = pais.flags.png;
            const poblacion = pais.population.toLocaleString();
            const idioma = Object.values(pais.languages)[0];
            const moneda = Object.values(pais.currencies)[0].name;
            
            document.getElementById('info').innerHTML = `
                <h2>${nombre}</h2>
                <img src="${bandera}" alt="Bandera de ${nombre}">
                <p><strong>Población:</strong> ${poblacion}</p>
                <p><strong>Idioma principal:</strong> ${idioma}</p>
                <p><strong>Moneda:</strong> ${moneda}</p>
            `;
        })
        .catch(error => {
            console.error('Error al obtener los datos:', error);
            document.getElementById('info').innerHTML = '<p>Error al obtener los datos.</p>';
        });
}
