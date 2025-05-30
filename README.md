📘 VLSM Calculator (Bash)

Una herramienta de línea de comandos escrita en Bash para calcular subredes usando VLSM (Variable Length Subnet Masking) de forma rápida e interactiva.
🚀 Características

    ✅ Soporte para un número ilimitado de subredes

    ✅ Cálculo automático de:

        Dirección de red

        Máscara de subred

        Dirección de broadcast

        Cantidad de hosts válidos

        Rango de IPs útiles

    ✅ Validación de entradas

    ✅ Modo interactivo con opción de repetir sin cerrar la terminal

📥 Instalación

No requiere instalación. Solo necesitas Bash (v4+).

🧪 Uso

Ejecuta el script desde terminal:

./vlsm_calc.sh

El script te pedirá:

    Dirección de red base (ej. 192.168.0.0)

    Máscara en formato CIDR (ej. 24)

    Número de subredes

    Cantidad de hosts por subred

🖥 Ejemplo

Introduce la red base (ej: 192.168.1.0): 192.168.1.0
Introduce la máscara en CIDR (ej: 24): 24
¿Cuántas subredes necesitas?: 3
Número de hosts para subred 1: 100
Número de hosts para subred 2: 50
Número de hosts para subred 3: 10

Resultado:

📦 Subred para 100 hosts:
  ▶ Red:           192.168.1.0
  ▶ Máscara:       255.255.255.128 (/25)
  ▶ Rango útil:    192.168.1.1 - 192.168.1.126
  ▶ Broadcast:     192.168.1.127
  ▶ Hosts útiles:  126

🧾 Requisitos

    Bash (v4 o superior)

    Compatible con Linux, macOS y WSL (Windows Subsystem for Linux)

📄 Licencia

Este proyecto está licenciado bajo la MIT License.📘 VLSM Calculator (Bash)

Una herramienta de línea de comandos escrita en Bash para calcular subredes usando VLSM (Variable Length Subnet Masking) de forma rápida e interactiva.
🚀 Características

    ✅ Soporte para un número ilimitado de subredes

    ✅ Cálculo automático de:

        Dirección de red

        Máscara de subred

        Dirección de broadcast

        Cantidad de hosts válidos

        Rango de IPs útiles

    ✅ Validación de entradas

    ✅ Modo interactivo con opción de repetir sin cerrar la terminal

📥 Instalación

No requiere instalación. Solo necesitas Bash (v4+).

git clone https://github.com/tu-usuario/vlsm-calculator.git
cd vlsm-calculator
chmod +x vlsm_calc.sh

🧪 Uso

Ejecuta el script desde terminal:

./vlsm_calc.sh

El script te pedirá:

    Dirección de red base (ej. 192.168.0.0)

    Máscara en formato CIDR (ej. 24)

    Número de subredes

    Cantidad de hosts por subred

🖥 Ejemplo

Introduce la red base (ej: 192.168.1.0): 192.168.1.0

Introduce la máscara en CIDR (ej: 24): 24

¿Cuántas subredes necesitas?: 3

Número de hosts para subred 1: 100

Número de hosts para subred 2: 50

Número de hosts para subred 3: 10

Resultado:

📦 Subred para 100 hosts:
  ▶ Red:           192.168.1.0
  ▶ Máscara:       255.255.255.128 (/25)
  ▶ Rango útil:    192.168.1.1 - 192.168.1.126
  ▶ Broadcast:     192.168.1.127
  ▶ Hosts útiles:  126

🧾 Requisitos

    Bash (v4 o superior)

    Compatible con Linux, macOS y WSL (Windows Subsystem for Linux)
