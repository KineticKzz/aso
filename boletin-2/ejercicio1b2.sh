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
1 "Listar archivos" \
2 "Ver directorios de trabajo" \
3 "Crear directorio" \
4 "Borrar directorio" \
5 "Crear usuario" \
6 "Borrar usuario" \
7 "Salir" 2>fich
opcion=`cat fich`
rm -r fich
}

dialog --infobox "Realizando las comprobaciones necesarias." 0 0; sleep 2;clear

comprobacionRoot
comprobacionParametros $#

opcion=0
while [ $opcion -ne 7 ]
do
funcionMenu
	case $opcion in 
	1) ls -la;;
	7) exit;;
	*) exit 1;;
	esac
done


