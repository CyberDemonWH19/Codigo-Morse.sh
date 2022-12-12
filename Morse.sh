#!/usr/bin/bash
source Diccionario.sh

# Colores
verde="\e[0;32m\033[1m"
NC="\033[0m\e[0m"
rojo="\e[0;31m\033[1m"
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
morado="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
gris="\e[0;37m\033[1m"

#Codificar
function Codificar() {
    # Declaración de la variable que almacenará el texto en código Morse
    texto_morse=""
    #Variable ingresada por el usuario
    echo -e "${turquesa}Ingrese el texto a convertir en Morse:\n${NC}"
    read texto
    # Bucle que recorre cada letra del texto ingresado
    for ((i = 0; i < ${#texto}; i++)); do
        # Acceso a la representación en código Morse de la letra actual
        letter="${texto:$i:1}"
        morse_letter="${morse[$letter]}"
        # Concatenación de la representación en código Morse de la letra
        # al texto en código Morse final
        texto_morse="$texto_morse$morse_letter "
    done
    # Impresión del texto en código Morse
    echo -e "${verde}El texto en código Morse es:${NC}\n${amarillo}$texto_morse${NC}"
}

#Decodificar
function Decodificar() {
    # Declaración de la variable que almacenará el texto original
    texto=""
    echo -e "${turquesa}Ingrese el codigo morse a descifrar:\n${NC}"
    read texto_morse
    # Bucle que recorre cada símbolo del código Morse
    for simbolo_morse in $texto_morse; do
        # Búsqueda del símbolo en el diccionario
        for letra in "${!morse[@]}"; do
            if [[ "${morse[$letra]}" == "$simbolo_morse" ]]; then
                # Si el símbolo se encuentra en el diccionario, se agrega
                # la correspondiente letra al texto original y un espacio
                texto="$texto$letra"
                break
            fi
        done
    done
    # Impresión del texto original
    echo -e "${verde}El codigo decodificado es:${NC}\n${amarillo}$texto${NC}"
}

function helpPanel() {
    echo -e "${morado}Modo de uso:${NC}\n\t${azul}./Morse.sh -m Codificar\n\t./Morse.sh -m Decodificar${NC}"
}

declare -i parametros=0
while getopts ":m:h:" arg; do
    case $arg in
    m) modo=$OPTARG && let parametros+=1 ;;
    h) helpPanel ;;
    esac
done
if [ $parametros -ne 1 ]; then
    helpPanel
else
    if [ "$modo" == "Codificar" ] || [ "$modo" == "codificar" ] || [ "$modo" == "CODIFICAR" ]; then
        Codificar
    elif [ "$modo" == "Decodificar" ] || [ "$modo" == "decodificar" ] || [ "$modo" == "DECODIFICAR" ]; then
        Decodificar
    else
        echo -e "Modo no conocido"
        exit 1
    fi
fi
