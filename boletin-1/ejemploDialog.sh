#!/bin/bash
#Ejemplos con dialog
clear
dialog --nocancel --inputbox "Nombre del archivo: " 0 0 2>fich
nombre=`cat fich`
rm -f fich
dialog --yesno "Quiere que se muestre el fichero $(echo $nombre)?" 0 0
if [ $? -eq 0 ]
then
	dialog --textbox $nombre 0 0
else
	exit
fi
clear
