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
	funcionRedInterna
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
a)
	dialog --nocancel --msgbox "Tu configuracion actual es: $(cat /etc/network/interfaces)" 0 0
;;

b)
	dialog --nocancel --inputbox "Nombre de la red. Ej: br1, br2... : " 0 0 2>fich1
	nombreRedEst=$(cat fich1); rm -f fich1
	dialog --nocancel --inputbox "¿A que interfaz está enlazada? " 0 0 2>fich2
	interfaz=$(cat fich2); rm -r fich2
	dialog --nocancel --inputbox "Dirección ip: " 0 0 2>fich3
	ipRedEst=$(cat fich3); rm -r fich3
	dialog --nocancel --inputbox "Máscara: " 0 0 2>fich4
	maskRedEst=$(cat fich4); rm -r fich4
	dialog --nocancel --inputbox "Puerta de enlace: " 0 0 2>fich5
	gateRedEst=$(cat fich5); rm -r fich5
	dialog --nocancel --inputbox "Red: " 0 0 2>fich6
	netRedEst=$(cat fich6); rm -r fich6
	dialog --nocancel --inputbox "Broadcast: " 0 0 2>fich7
	broadRedEst=$(cat fich7); rm -r fich7
	
	fecha=$(date +%d-%m-%Y)
	cp /etc/network/interfaces /etc/network/interfaces_COPIA_$fecha
	dialog --infobox "Realizando una copia de seguridad del fichero interfaces en /etc/network/..." 0 0;sleep 3
	
	echo "#Fichero de configuracion con el adaptador puente para KVM" > /etc/network/interfaces
	echo "auto lo" >> /etc/network/interfaces
	echo "iface lo inet loopback" >> /etc/network/interfaces
	echo "" >> /etc/network/interfaces
	echo "auto $interfaz" >> /etc/network/interfaces
	echo "iface $interfaz inet manual" >> /etc/network/interfaces
	echo "" >> /etc/network/interfaces
	echo "auto $nombreRedEst" >> /etc/network/interfaces
	echo "iface $nombreRedEst inet static" >> /etc/network/interfaces
	echo "bridge_ports $interfaz" >> /etc/network/interfaces
	echo "bridge_stf off" >> /etc/network/interfaces
	echo "address $ipRedEst" >> /etc/network/interfaces
	echo "netmask $maskRedEst" >> /etc/network/interfaces
	echo "gateway $gateRedEst" >> /etc/network/interfaces
	echo "network $netRedEst" >> /etc/network/interfaces
	echo "broadcast $broadRedEst" >> /etc/network/interfaces
	dialog --infobox "Configuración realizada con éxito" 0 0;sleep 3
	ip a flush dev $interfaz 2>/dev/null
	ip a flush dev $nombreRedEst 2>/dev/null
	systemctl restart networking
	dialog --infobox "Limpiando configuracion interfaces y reiniciando el servicio" 0 0;sleep 3
	dialog --nocancel --msgbox "Ha finalizado la configuracion, si no tiene internet deberá reiniciar el sistema para que los cambios se apliquen correctamente" 0 0
;;


c)
	dialog --nocancel --inputbox "Introduzca el bridge: " 0 0 2>fich9
	bridge=$(cat fich9); rm -f fich9
	dialog --nocancel --inputbox "¿A que interfaz está enlazada? " 0 0 2>fich8
	interfaz=$(cat fich8); rm -f fich8
	macInt=$(ip a show $interfaz|grep -w "link/ether"|cut -d" " -f6)
	macBridge=$(ip a show $bridge|grep -w "link/ether"|cut -d" " -f6)
	if [ $macInt = $macBridge ]
	then
		dialog --nocancel --msgbox "Están enlazados" 0 0
	else
		dialog --nocancel --msgbox "No están enlazados" 0 0
	fi
;;


d)
	nano /etc/network/interfaces
;;


f)
	continue;;
esac
}
funcionAccionesMenuBridgeDinamico(){
case $opcionMenuBridgeDinamico in
a)echo "hola soy la opcion a"; sleep 1

;;

b)
	dialog --nocancel --inputbox "Nombre de la red. Ej: br1, br2... : " 0 0 2>fich1
	nombreRedDin=$(cat fich1); rm -f fich1
	dialog --nocancel --inputbox "¿A que interfaz está enlazada? " 0 0 2>fich2
	interfaz=$(cat fich2); rm -r fich2
	
	fecha=$(date +%d-%m-%Y)
	cp /etc/network/interfaces /etc/network/interfaces_COPIA_$fecha
	dialog --infobox "Realizando una copia de seguridad del fichero interfaces en /etc/network/..." 0 0;sleep 3
	
	echo "#Fichero de configuracion con el adaptador puente para KVM" > /etc/network/interfaces
	echo "auto lo" >> /etc/network/interfaces
	echo "iface lo inet loopback" >> /etc/network/interfaces
	echo "" >> /etc/network/interfaces
	echo "auto $interfaz" >> /etc/network/interfaces
	echo "iface $interfaz inet manual" >> /etc/network/interfaces
	echo "" >> /etc/network/interfaces
	echo "auto $nombreRedEst" >> /etc/network/interfaces
	echo "iface $nombreRedEst inet dhcp" >> /etc/network/interfaces
	echo "bridge_ports $interfaz" >> /etc/network/interfaces
	echo "bridge_stf off" >> /etc/network/interfaces
	
	dialog --infobox "Configuración realizada con éxito" 0 0;sleep 3
	ip a flush dev $interfaz 2>/dev/null
	ip a flush dev $nombreRedDin 2>/dev/null
	systemctl restart networking
	dialog --infobox "Limpiando configuracion interfaces y reiniciando el servicio" 0 0;sleep 3
	dialog --nocancel --msgbox "Ha finalizado la configuracion, si no tiene internet deberá reiniciar el sistema para que los cambios se apliquen correctamente" 0 0
;;


c)
	dialog --nocancel --inputbox "Introduzca el bridge: " 0 0 2>fich9
	bridge=$(cat fich9); rm -f fich9
	dialog --nocancel --inputbox "¿A que interfaz está enlazada? " 0 0 2>fich8
	interfaz=$(cat fich8); rm -f fich8
	macInt=$(ip a show $interfaz|grep -w "link/ether"|cut -d" " -f6)
	macBridge=$(ip a show $bridge|grep -w "link/ether"|cut -d" " -f6)
	if [ $macInt = $macBridge ]
	then
		dialog --nocancel --msgbox "Están enlazados" 0 0
	else
		dialog --nocancel --msgbox "No están enlazados" 0 0
	fi
;;


f)
	continue;;
esac
}
funcionRedInterna(){
dialog --nocancel --inputbox "Nombre de la red interna: " 0 0 2>fich
nombreInterna=$(cat fich); rm -f fich
apt install uuidgen 2>/dev/null
uuidNueva="  <uuid>$(uuidgen)</uuid>"
uuidActual=$(grep -w uuid /etc/libvirt/qemu/networks/default.xml)
sed "s/${uuidActual}/${uuidNueva}/g" /etc/libvirt/qemu/networks/default.xml > prueba.xml
sleep 3;exit
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




