#/bin/bash
#Autor: Sergio Lagüens Tornero
#Fecha: 23/10/2020
#Descripción: Esta es la plantilla para cualquier script

funcionComprobacionRoot(){
if [ $(id -u) -ne 0 ] ; then
	dialog --infobox "No eres el root" 0 0
	sleep 2;clear;exit 1
else
	continue
fi;}
funcionComprobacionParametros(){
if [ $1 -eq 2 ] ; then
	continue
else
	dialog --infobox "El número de parámetros es incorrecto, tienen que ser x parámetros" 0 0
	sleep 2;clear;exit 1
fi;}
funcionMenu(){
dialog --nocancel --menu "NOMBRE" 0 0 5 \
1 "Opcion 1" \
2 "Opcion 2" \
3 "Opcion 3" \
4 "Opcion 4"
}

dialog --infobox "Realizando las comprobaciones necesarias." 0 0; sleep 2;clear

comprobacionRoot
comprobacionParametros $#
funcionMenu

