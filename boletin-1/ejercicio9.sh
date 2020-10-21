#!/bin/bash
#Realizar un script que reciba dos parámetros. 
#El primer parámetro puede ser:
#	-c Para comprimir
#	-d Para descomprimir
#El segundo parámetro:
#Indica el archivo a comprimir o bien el archivo a descomprimir, según el primer parámetro.
#El script se ejecutará:
#	sh ejercicio9.sh parametro1 parametro2

#Habrá que comprobar que se ha introducido dos parámetros y que el archivo existe.

if [ $(id -u) -ne 0 ]
then
	dialog --infobox "No eres el root" 0 0
	sleep 2
	clear
	exit
else
	continue
fi

if [ $# -eq 2 ]
then
	continue
else
	dialog --infobox "No has introducido los dos parámetros" 0 0;sleep 2;clear;exit
fi


case $1 in
c) 
	if [ -f $2 ]
	then
		continue
	else
		dialog --infobox "El fichero no existe" 0 0;sleep 2;clear;exit
	fi
	gzip $2 >/dev/null
	dialog --infobox "Archivo comprimido con exito" 0 0;sleep 2;clear;exit;;
d) if [ -f $2 ]
	then
		continue
	else
		dialog --infobox "El fichero no existe" 0 0;sleep 2;clear;exit
	fi
	gzip -d $2 >/dev/null
	dialog --infobox "Archivo descomprimido con exito" 0 0;sleep 2;clear;exit;;
*) dialog --infobox "El primer parametro debe ser comprimir (c) o descomprimir (d) y el segundo, un fichero." 0 0;sleep 2;clear;exit
esac

















