#!/bin/bash
  # Print a message about disk useage.
    space_free=$( df -h | awk '{ print $5 }' | sort -n | tail -n 1 | sed 's/%//' )
    case $space_free in
    [1-5]*)
    echo Espacio libre suficiente en el sistema de almacenamiento
    ;;
    [6-7]*)
    echo Podría haber problemas de espacio en alguna unidad de almacenamiento
    ;;
    8*)
    echo Deberías buscar más espacio libre, eliminando aquello que no utilizas
    ;;
    9*)
    echo Hay un problema serio de falta de espacio en tu unidad
    ;;
    *)
    echo Algo no funciona bien...
    esac