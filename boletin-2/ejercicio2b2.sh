#/bin/bash
#Autor: Sergio Lagüens Tornero
#Fecha: 23/10/2020
#Descripción: Esta es la plantilla para cualquier script

funcionComprobacionParametros(){
if [ $1 -eq 2 ] ; then
	continue
else
	dialog --infobox "El número de parámetros es incorrecto, tienen que ser x parámetros" 0 0
	sleep 2;clear;exit 1
fi;}
funcionComprobarFicheros(){
if [ -f $1 ]
then
	continue
else
	echo "Los dos parámetros tienen que ser dos ficheros"
	sleep 3; exit 1
fi
}

funcionComprobacionParametros $#
funcionComprobarFicheros $1
funcionComprobarFicheros $2

head -1 $1 > aux
echo "\n# FILE: $1" >> aux
echo "\n# $(cat $2)" >> aux
echo "\n# $(date)" >> aux
grep -v "$(head -1 $1)" $1 >> aux

cat aux

rm -r aux
