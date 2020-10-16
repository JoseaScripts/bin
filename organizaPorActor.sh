#!/bin/bash
# modificado: 15-10-2020

# Herramienta para facilitar la organización de archivos de vídeo

# Recorre la $UBICACION recuperando uno a uno el nombre de los actores/actrices
# Luego busca coincidencias en los nombres de archivo ubicados en $ARCHIVOS

## Debo comprobar si esta función no está ya incluida en 'pelis.sh'.

## VARIABLES ##

## Ubicación de los archivos objeto de la búsqueda
ARCHIVOS='/var/media/Cine/Descargas/'
## Ubicación de los directorios de cada Star
UBICACION='/var/media/Cine/Actor'
i=0

while read star
 do
  if [[ $i -eq 0 ]]
   then
     echo "Directorio de búsqueda: $star" # El primer resultado es el directorio principal
   else
	#echo ${star##*/}
	array=( ${star##*/} )
	echo "star: $star"
	NOMBRE=${array[0]//.\//}
	APELLIDO=${array[1]}
	echo "$NOMBRE, $APELLIDO"

	find $ARCHIVOS -type d -iname "*$NOMBRE?$APELLIDO*" -exec mv -i -t "$star" {} \;
	find $ARCHIVOS -type f -iname "*$NOMBRE?$APELLIDO*" -exec mv -i -t "$star" {} \;
   fi
i=1
done < <(find $UBICACION -maxdepth 1 -type d | sort | uniq)
