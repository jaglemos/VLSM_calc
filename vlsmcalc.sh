#!/bin/bash

# --- FUNCIONES ---

# Siguiente red válida
next_network() {
  local ip=$1
  local increment=$2
  IFS='.' read -r o1 o2 o3 o4 <<< "$ip"
  ipdec=$(( (o1<<24) + (o2<<16) + (o3<<8) + o4 + increment ))
  echo "$(( (ipdec>>24)&255 )).$(( (ipdec>>16)&255 )).$(( (ipdec>>8)&255 )).$(( ipdec&255 ))"
}

# Máscara mínima según número de hosts
get_mask_and_size() {
  local hosts=$1
  local bits=32
  while (( (2 ** (32 - bits)) - 2 < hosts )); do
    ((bits--))
  done
  echo "/$bits"
}

# Convertir CIDR a máscara decimal
cidr_to_mask() {
  local cidr=$1
  local mask=""
  for i in {1..4}; do
    if (( cidr >= 8 )); then
      mask+="255"
      cidr=$((cidr - 8))
    else
      mask+=$((256 - 2 ** (8 - cidr)))
      cidr=0
    fi
    [[ $i -lt 4 ]] && mask+="."
  done
  echo "$mask"
}

# Validar IP
is_valid_ip() {
  [[ $1 =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] && return 0 || return 1
}

# Validar CIDR
is_valid_cidr() {
  [[ $1 =~ ^[0-9]+$ && $1 -ge 1 && $1 -le 30 ]] && return 0 || return 1
}

# IP a decimal
ip_to_dec() {
  IFS='.' read -r o1 o2 o3 o4 <<< "$1"
  echo $(( (o1<<24) + (o2<<16) + (o3<<8) + o4 ))
}

# Decimal a IP
dec_to_ip() {
  local ip=$1
  echo "$(( (ip>>24)&255 )).$(( (ip>>16)&255 )).$(( (ip>>8)&255 )).$(( ip&255 ))"
}

# --- BUCLE PRINCIPAL ---

while true; do
  clear
  echo "🔧 Calculadora de Subredes con VLSM"
  echo "-----------------------------------"

  # Entrada de red base
  while true; do
    read -p "Introduce la red base (ej: 192.168.1.0): " base_ip
    is_valid_ip "$base_ip" && break
    echo "❌ Dirección IP inválida."
  done

  # Entrada de máscara
  while true; do
    read -p "Introduce la máscara en CIDR (ej: 24): " cidr
    is_valid_cidr "$cidr" && break
    echo "❌ CIDR inválido. Debe estar entre 1 y 30."
  done

  # Número de subredes
  while true; do
    read -p "¿Cuántas subredes necesitas?: " num_subnets
    [[ "$num_subnets" =~ ^[0-9]+$ && "$num_subnets" -ge 1 ]] && break
    echo "❌ Ingresa un número válido (1 o más)."
  done

  declare -a hosts
  for (( i=1; i<=num_subnets; i++ )); do
    while true; do
      read -p "Número de hosts para subred $i: " h
      [[ "$h" =~ ^[0-9]+$ && "$h" -ge 1 ]] && hosts[i]=$h && break
      echo "❌ Número inválido. Ingresa un número positivo."
    done
  done

  # Ordenar requerimientos de mayor a menor
  sorted_hosts=($(for h in "${hosts[@]}"; do echo "$h"; done | sort -nr))

  echo
  echo "📡 Calculando subredes desde $base_ip/$cidr"
  echo "---------------------------------------------"
  current_ip=$base_ip

  for h in "${sorted_hosts[@]}"; do
    mask_cidr=$(get_mask_and_size "$h")
    subnet_size=$((2 ** (32 - ${mask_cidr:1})))
    netmask=$(cidr_to_mask ${mask_cidr:1})
    broadcast=$(next_network "$current_ip" "$((subnet_size - 1))")
    usable_hosts=$((subnet_size - 2))

    # Calcular rango útil
    ip_start_dec=$(( $(ip_to_dec "$current_ip") + 1 ))
    ip_end_dec=$(( $(ip_to_dec "$broadcast") - 1 ))
    first_ip=$(dec_to_ip "$ip_start_dec")
    last_ip=$(dec_to_ip "$ip_end_dec")

    echo "📦 Subred para $h hosts:"
    echo "  ▶ Red:           $current_ip"
    echo "  ▶ Máscara:       $netmask ($mask_cidr)"
    echo "  ▶ Rango útil:    $first_ip - $last_ip"
    echo "  ▶ Broadcast:     $broadcast"
    echo "  ▶ Hosts útiles:  $usable_hosts"
    echo

    current_ip=$(next_network "$current_ip" "$subnet_size")
  done

  # Repetir o salir
  echo
  while true; do
    read -p "¿Deseas calcular otra red? (s/n): " opt
    case "$opt" in
      [sS]*) break ;;
      [nN]*) echo "👋 Saliendo..."; exit 0 ;;
      *) echo "❌ Opción no válida. Escribe s o n." ;;
    esac
  done
done

