#!/bin/bash
echo "Script bash para la instalación de un botón de apagado en el escritorio"
# Se copian los archivos de script a la carpeta correspondiente
cp saludo.sh shutdown.sh ~/.local/bin/
# Copia botón de apagado al escritorio
cp switch_button.desktop ~/.local/share/applications
# Instala espeak y mbrola si no están instaladas en el sistema
if [ ! -f /usr/bin/espeak] ;
then
echo "Instalando herramienta espeak..."
sudo apt install espeak espeak-data -y
fi
if [ ! -f /usr/bin/mbrola ];
then
echo "Instalando herramienta mbrola..."
sudo apt install mbrola mbrola-es1 mbrola-es2 -y
fi
