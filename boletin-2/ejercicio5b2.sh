#/bin/bash
#Autor: Sergio Lagüens Tornero
#Fecha: 23/10/2020
#Descripción: Esta es la plantilla para cualquier script
clear

#FUNCIONES
funcionMenu(){
#echo "Menu de contactos: "
#echo "___________________"
#echo ""
#echo "1.- Listar Contactos"
#echo "2.- Añadir un contacto"
#echo "3.- Buscar un contacto"
dialog --nocancel --menu "MENÚ CONTACTOS" 40 20 5 \
1 "Listar contactos" \
2 "Añadir contacto" \
3 "Buscar un contacto" \
4 "Borrar un contacto" \
5 "Salir" \ 2>fich
opcion=$(cat fich)
rm -r fich
}

#BLOQUE PRINCIPAL
opcion=0
while [ $opcion -gt 5 ]
do
funcionMenu
case $opcion in 
1)	dialog --nocancel --inputbox "¿Quiere ordenarlo por 	  ciudad (c) o por nombre (n)? [n/c]" 0 0 2>fich2
	orden=$(cat fich2)
	rm -r fich2
case $orden in	
	c)	dialog --nocancel --msgbox "$(cat lista.txt|sort -t: -k4)" 0 0
	;;
	n)	dialog --nocancel --msgbox "$(cat lista.txt|sort -t: -k1)" 0 0
	;;
	*)dialog --nocancel --msgbox "Opción incorrecta, volviendo al menú principal" 0 0; break;
;;

2)	dialog --nocancel --inputbox "Nombre: " 0 0 2>fich3
	nombre=$(cat fich3)
	rm -r fich3
	
	dialog --nocancel --inputbox "Direccion: " 0 0 2>fich4
	direccion=$(cat fich4)
	rm -r fich4
	
	dialog --nocancel --inputbox "Teléfono: " 0 0 2>fich5
	telefono=$(cat fich5)
	rm -r fich5
	
	dialog --nocancel --inputbox "Ciudad: " 0 0 2>fich6
	ciudad=$(cat fich6)
	rm -r fich6
	
	echo "$nombre:$telefono:$direccion:$ciudad" >>lista.txt
;;

3)	dialog --nocancel --inputbox "Introduzca el nombre: " 0 0 2>fich7
	nombreBuscar=$(cat fich7)
	rm -r fich7
	
	cat lista.txt|grep -w $nombreBuscar
;;

4)	dialog --nocancel --inputbox "Introduzca el nombre de quien desea borrar: " 0 0 2>fich8
	nombreBorrar=$(cat fich8)
	rm -r fich8
	
	if [ $(grep -i $nombreBorrar|wc -l) -ne 0 ]
	then
		cat lista.txt|grep -i $nombreBorrar > aux
		for i in 
	
	
	
	
	
	
	
	
