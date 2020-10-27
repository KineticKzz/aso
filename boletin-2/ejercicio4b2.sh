#/bin/bash
#Autor: Sergio Lagüens Tornero
#Fecha: 23/10/2020
#Descripción: Esta es la plantilla para cualquier script
clear


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
funcionComprobarUsuario(){
who|grep -w $1 > /dev/null
if [ $? -eq 0 ]
then
	return 0
else
	return 1
fi
}
funcionDesconectarUsuario(){
	pkill -9 -u $1
	echo "El usuario $1 ha sido desconectado"
}

funcionComprobacionRoot
funcionComprobacionParametros $#


case $1 in
-v)	funcionComprobarUsuario $2
	if [ $? -eq 0 ]
	then
		echo "El usuario está conectado"
	else
		echo "El usuario no está conectado"
	fi
;;


-m) funcionComprobarUsuario $2
	if [ $? -eq 0 ]
	then 
		funcionDesconectarUsuario $2
	else
		echo "El usuario no está conectado"
	fi
;;

*)	echo "El primer parámetro debe ser una '-v' o '-m'"
;;
esac
	
	
	
	
	
	
	
	
	
	
	
