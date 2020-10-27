#/bin/bash
#Autor: Sergio Lagüens Tornero
#Fecha: 23/10/2020
#Descripción: Esta es la plantilla para cualquier script

funcionComprobacionRoot(){
if [ $(id -u) -ne 0 ] ; then
	clear "No eres el root"
	sleep 2;clear;exit 1
else
	continue
fi;}
funcionComprobacionParametros(){
if [ $1 -eq 2 ] ; then
	continue
else
	echo "El número de parámetros es incorrecto, tienen que ser x parámetros"
	sleep 2;clear;exit 1
fi;}

comprobacionRoot
comprobacionParametros $#

opcion=$1
dni=$2

emp=$(cat empleados|grep -i $dni)
numero=$(echo $emp|cut -d: -f1)
nombre=$(echo $emp|cut -d: -f2)
apel=$(echo $emp|cut -d: -f3)
puesto=$(echo $emp|cut -d: -f6)
suelmen=$(echo $emp|cut -d":" -f5)
suelex=$(cat pagas_extras|grep -i $puesto|cut -d: -f2)
x=$(expr $suelmen \* 12)
y=$(expr $suelex \* 2)
suelan=$(expr $x + $y)

case $1 in 
-m) clear
	echo "DATOS DEL EMPLEADO"
	echo "_______________________"
	echo ""
	echo "Nº Empleado: $numero"
	echo "Nombre: $nombre"
	echo "Apellido: $apel"
	echo "DNI: $dni"
	echo "Puesto: $puesto"
	echo "Sueldo mensual: $suelmen"
	echo "_______________________\n"
;;

-a)	clear
	echo "SUELDO ANUAL DEL EMPLEADO"
	echo "_______________________"
	echo ""
	echo "Nombre: $nombre"
	echo "Apellido: $apel"
	echo "DNI: $dni"
	echo "Sueldo mensual: $suelmen"
	echo "Sueldo anual: $suelan"
	echo "_______________________\n"
;;

*)	echo "Parámetro incorrecto, el priemr parámetro debe de ser 'm' o 'a'"
	exit 1;
esac
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
