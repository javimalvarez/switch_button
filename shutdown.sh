#!/bin/bash
saludo=$(bash ~/.local/bin/saludo.sh)
if groups | grep -q '\bsudo\b' || groups | grep -q '\bwheel\b'; then
    # Se mostrará al usuario un menú
    # Título del menú
    titulo="Menú de apagado"
    zenity --info --title="$titulo" --text="$USER bienvenido al menu de apagado de bash" --width=150 --timeout=3
    # Opciones del menú
    opciones=(
        "Cerrar sesión"
        "Reiniciar"
        "Apagar"
    )

    # Mostrar el menú y capturar la selección
    while true; do
        seleccion=$(zenity --list \
                        --title="$titulo" \
                        --text="Seleccione una opción:" \
                        --column="Opciones" \
                        "${opciones[@]}" \
                        --width=100 \
                        --height=300)

        # Si el usuario cancela o cierra la ventana
        if [ $? -ne 0 ]; then
            zenity --warning --title="$titulo" --text="Operación cancelada" --width=150 --timeout=3
            exit 0
        fi

        # Procesar la selección
        case "$seleccion" in
            "Cerrar sesión")
                (
                for ((i=30; i>=0; i--)); do
                    echo $(( (30 - i) * 100 / 30 ))  # Calculate percentage
                    echo "# Se cerrará la sesión en: $i segundos"
                    sleep 1
                done
                ) | zenity --progress \
                --title="Cerrar sesión" \
                --text="Starting..." \
                --percentage=0 \
                --cancel-label="No cerrar sesión" \
                --auto-close
                if [ $? -ne 0 ]; then
                    zenity --warning --title="Cerrar sesión" --text="Se ha cancelado la operacion" --width=150 --timeout=3
                    exit
                fi
                espeak "$saludo $USER, hasta pronto" -v "mb/mb-es2" 2> /dev/null
                pkill -KILL -u $USER
                ;;

            "Reiniciar")
                (
                for ((i=30; i>=0; i--)); do
                    echo $(( (30 - i) * 100 / 30 ))  # Calculate percentage
                    echo "# Se reiniciará el equipo en: $i segundos"
                    sleep 1
                done
                ) | zenity --progress \
                --title="Reiniciar" \
                --text="Starting..." \
                --percentage=0 \
                --cancel-label="Cancelar reinicio" \
                --auto-close
                if [ $? -ne 0 ]; then
                    zenity --warning --title="Reiniciar" --text="Se ha cancelado la operacion" --width=150 --timeout=3
                    exit
                fi
                espeak "$saludo $USER, hasta pronto" -v "mb/mb-es2" 2> /dev/null
                sudo reboot now
                ;;

            "Apagar")
                (
                for ((i=30; i>=0; i--)); do
                    echo $(( (30 - i) * 100 / 30 ))  # Calculate percentage
                    echo "# Se apagará el equipo en: $i segundos"
                    sleep 1
                done
                ) | zenity --progress \
                --title="Apagar" \
                --text="Starting..." \
                --percentage=0 \
                --cancel-label="Cancelar apagado" \
                --auto-close

                if [ $? -ne 0 ]; then
                    zenity --warning --title="Apagar" --text="Se ha cancelado la operacion" --width=150 --timeout=3
                    exit
                fi
                espeak "$saludo $USER, hasta pronto" -v "mb/mb-es2" 2> /dev/null
                sudo shutdown now
                ;;
            *)
                zenity --error --text="Opción no válida" --width=150
                ;;
        esac
    done
else
    zenity --warning --title="aviso" --text="El usuario no tiene privilegios de administrador" --no-wrap --no-markup
fi

