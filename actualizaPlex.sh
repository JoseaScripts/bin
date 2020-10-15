#!/bin/bash
## actualizaPlex.sh
## modificado: 15-10-2020

cd

read -p "¿Ya descargaste la nueva versión a instalar? Si/no: " read_descarga
    descarga=${read_descarga:=si}
    descarga=${read_descarga,,}
    [[ "$descarga" == "no" ]] && echo "Debes descargar el paquete y renombrarlo a 'plex-server-.deb" && exit 0

read -p "¿El paquete descargado tiene el nombre plex-server.deb? Si/no: " read_nombre
    nombre=${read_nombre:=Si}
    nombre=${read_nombre,,}
    [[ "$nombre" == "no" ]] && echo "Debes descargar el paquete y renombrarlo a 'plex-server-.deb" && exit 0


sudo systemctl stop transmission-daemon
sudo systemctl status transmission-daemon
read -t 1 -p "Transmission detenido."

sudo systemctl stop plexmediaserver
read -t 1 -p "Servidor Plex detenido."

read -p "Actualizar el sistema (Si/no):" read_actualizar
    _actualizar=${read_actualizar:=si}
    _actualizar=${read_actualizar,,}

read -p "Crear copia de seguridad (Si/no): " read_copia
    _copia=${read_copia:=si}
    _copia=${read_actualizar,,}


## FUNCIONES
function actualizarSistema() {
if [[ "$_actualizar" == "si" ]]; then
    printf "\nSe va a actualizar el sistema.\n";
    sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade
    sudo apt-get autoremove && sudo apt-get clean
fi
}

function copiaSeguridad() {
    if [[ "$_actualizar" == "si" ]]; then
	printf "\nHaciendo copia de seguridad\n";
	cd /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/
	sudo rsync -avzu --exclude 'Cache' ./ /home/pi/respaldos/Plex/
    fi
}

actualizarSistema
copiaSeguridad

sudo dpkg -i ~/plex/plex-server.deb
