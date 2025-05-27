import json
import os

input_file = 'starships.json'  # <-- Cambia esto por el archivo que quieras limpiar
output_file = 'starships_clean.json'

def convert_numbers(obj):
    if isinstance(obj, dict):
        return {k: convert_numbers(v) for k, v in obj.items()}
    elif isinstance(obj, list):
        return [convert_numbers(i) for i in obj]
    elif isinstance(obj, str):
        # Intenta convertir a int
        try:
            if '.' in obj:
                return float(obj)
            return int(obj)
        except ValueError:
            return obj
    else:
        return obj

# Cargar archivo
with open(input_file, 'r', encoding='utf-8') as f:
    data = json.load(f)

# Procesar
cleaned = convert_numbers(data)

# Guardar archivo limpio
with open(output_file, 'w', encoding='utf-8') as f:
    json.dump(cleaned, f, indent=2, ensure_ascii=False)

print(f'✅ Archivo limpiado: {output_file}')
