#/bin/bash
#Autor: Sergio Lagüens Tornero
#Fecha: 30/10/2020
#Descripción: Ejercicio1 de kvm

funcionComprobacionRoot(){
if [ $(id -u) -ne 0 ] ; then
	clear "No eres el root"
	sleep 2;clear;exit 1
else
	continue
fi;}


### FUNCIONES MOSTRAR MENU ###
funcionMenuPrincipal(){
dialog --nocancel --title "KVM" --menu "MENÚ PRINCIPAL" 40 60 10 \
1 "Red Default" \
2 "Red Bridge Estática" \
3 "Definir una red Bridge Dinámica" \
4 "Definir una red interna personalizada" \
5 "Salir" 2>menuPrincipal
opcionMenuPrincipal=$(cat menuPrincipal)
rm -f menuPrincipal
}
funcionMenuRedDefault(){
dialog --nocancel --title "Menu Red Default" --menu "Elija una opcion:" 40 60 10 \
a "Consultar el estado de la red" \
b "Ver la configuracion de la red" \
c "Activar/Desactivar la red" \
d "Inicializar/No-inicializar la red" \
e "Modificar la configuracion" \
f "Volver al menú principal" 2>menuRedDefault
opcionMenuRedDefault=$(cat menuRedDefault)
rm -f menuRedDefault
}
funcionMenuBridgeEstatica(){
dialog --nocancel --title "Menu Bridge Estática" --menu "Elija una opcion:" 40 60 10 \
a "Ver la configuracion de la red" \
b "Definir una red bridge estática" \
c "Verificar bridge" \
d "Activar/Desactivar la red" \
e "Modificar la configuracion" \
f "Volver al menú principal" 2>menuBridgeEstatico
opcionMenuBridgeEstatico=$(cat menuBridgeEstatico)
rm -f menuBridgeEstatico
}
funcionMenuBridgeDinamico(){
dialog --nocancel --title "Menu Bridge Dinámico" --menu "Elija una opcion:" 40 60 10 \
a "Ver la configuracion de la red" \
b "Definir una red bridge dinámica" \
c "Verificar bridge" \
d "Activar/Desactivar la red" \
e "Volver al menú principal" 2>menuBridgeDinamico
opcionMenuBridgeDinamico=$(cat menuBridgeDinamico)
rm -f menuBridgeDinamico
}



### FUNCIONES ACCIONES MENUS ###
funcionAccionesMenuPrincipal(){
case $1 in
1)
	funcionMenuRedDefault
	funcionAccionesMenuRedDefault $opcionMenuRedDefault
;;


2)
	funcionMenuBridgeEstatica
	funcionAccionesMenuBridgeEstatico $opcionMenuBridgeEstatico
;;


3)
	funcionMenuBridgeDinamico
	funcionAccionesMenuBridgeDinamico $opcionMenuBridgeDinamico
;;


4)
	exit 0
;;


5) 
	dialog --infobox "Saliendo... Hasta otra!" 0 0;sleep 1;clear;exit 0
;;
esac
}
funcionAccionesMenuRedDefault(){
case $opcionMenuRedDefault in
a)
	dialog --nocancel --msgbox "Estado de la red: $(virsh net-info default)" 0 0
;;


b)
	dialog --nocancel --msgbox "Configuracion de la red: $(virsh net-dumpxml default)" 		0 0
;;


c)
	if [ $(virsh net-list --all|tr -s " "|awk -F" " '$1=="default" {print $2}') = "active" ]
	then
		dialog --yesno "El estado actual es activo, ¿desea desactivarlo? " 0 0
			if [ $? -eq 0 ]
			then
				virsh net-destroy default > /dev/null
				dialog --infobox "Deteniendo la red default..." 0 0;sleep 1
			else
				dialog --infobox "Saliendo sin desactivar la red" 0 0; sleep 1
			fi
	else
		dialog --yesno "El estado actual es inactivo, ¿desea activarla? " 0 0
			if [ $? -eq 0 ]
			then
				virsh net-start default > /dev/null
				dialog --nocancel --msgbox "Activando la red default..." 0 0;sleep 1
			else
				dialog --infobox "Saliendo sin activar la red" 0 0; sleep 1
			fi
	fi	
;;


d)
	if [ $(virsh net-list --all|grep -w default|wc -l) -eq 1 ]
	then
		dialog --yesno "La red está definida, ¿desea quitarla?" 0 0
		if [ $? -eq 0 ]
		then
			virsh net-destroy default > /dev/null
			dialog --infobox "Deteniendo la red default..." 0 0;sleep 1
			virsh net-undefine default > /dev/null
			dialog --infobox "Quitando la red..." 0 0;sleep 1
		else
			dialog --infobox "Saliendo y dejando la red definida..." 0 0; sleep 1
		fi
	else
		dialog --yesno "La red no está definida, ¿desea definirla?" 0 0; sleep 1
		if [ $? -eq 0 ]
		then
			virsh net-define default > /dev/null
			dialog --infobox "Definiendo la red..." 0 0;sleep 1
		else
			dialog --infobox "Saliendo sin definir la red..." 0 0;sleep 1
		fi
	fi
;;


e)
	virsh net-edit default
;;


f)
	continue;;
esac
}
funcionAccionesMenuBridgeEstatico(){
case $opcionMenuBridgeEstatico in
a)echo "hola soy la opcion a"; sleep 1

;;

b)echo "hola soy la opcion b"; sleep 1

;;


c)echo "hola soy la opcion c"; sleep 1

;;


d)echo "hola soy la opcion d"; sleep 1

;;


e)
	continue;;
esac
}
funcionAccionesMenuBridgeDinamico(){
case $opcionMenuBridgeDinamico in
a)echo "hola soy la opcion a"; sleep 1

;;

b)echo "hola soy la opcion b"; sleep 1

;;


c)echo "hola soy la opcion c"; sleep 1

;;


d)echo "hola soy la opcion d"; sleep 1

;;


e)
	echo "hola soy la opcion e"; sleep 1
;;

f)
	continue;;
esac
}



### BLOQUE PRINCIPAL ###
clear
funcionComprobacionRoot

opcionMenuPrincipal=0
while [ $opcionMenuPrincipal -lt 6 ]
do
	funcionMenuPrincipal
	funcionAccionesMenuPrincipal $opcionMenuPrincipal
done
	
	
	
	
	
	
	
	
	
	
	
	
