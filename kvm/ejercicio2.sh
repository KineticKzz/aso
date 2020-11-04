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
funcionMenu(){
dialog --nocancel --menu "MENU GESTION MAQUINAS KVM" 40 40 5 \
1 "Crear una máquina virtual" \
2 "Eliminar máquina virtual" \
3 "Salir" 2>fich1
opcion=$(cat fich1)
rm -r fich1
}
funcionComprobacionKVM(){
if [ $(apt policy qemu-kvm|grep ninguno|wc -l) -eq 0 ]
then
	continue
else
	apt install -y qemu-kvm
fi
}
funcionAccionesMenu(){
case $1 in
1)
	repetir=0
	while [ $repetir -eq 0 ]
	do
		dialog --nocancel --inputbox "Nombre de la máquina: " 0 0 2>fich2
		nombre=$(cat fich2);rm -r fich2
		dialog --nocancel --inputbox "RAM: " 0 0 2>fich3
		ram=$(cat fich3);rm -r fich3
		dialog --nocancel --inputbox "Tamaño del disco en GB: " 0 0 2>fich4
		tamano=$(cat fich4);rm -r fich4
		dialog --nocancel --inputbox "Nucleos: " 0 0 2>fich5
		nucleos=$(cat fich5);rm -r fich5
		dialog --nocancel --inputbox "Ruta de la imagen ISO: " 0 0 2>fich6
		iso=$(cat fich6);rm -r fich6
		dialog --nocancel --inputbox "Sistema operativo: " 0 0 2>fich7
		so=$(cat fich7);rm -r fich7
		dialog --nocancel --inputbox "Adaptador: " 0 0 2>fich8
		adaptador=$(cat fich8);rm -r fich8
		virt-install --connect qemu:///system --name $nombre --memory $ram --disk /var/lib/libvirt/images/$nombre.qcow2,size=$tamano --vcpus=$nucleos -c $iso --vnc --os-type $so --network bridge=$adaptador --noautoconsole --hvm --keymap es 2>/dev/null
		sleep 3
		
		dialog --yesno "¿Desea crear otra maquina?" 0 0
		if [ $? -eq 0 ]
		then
			repetir=0
		else
			repetir=1
		fi
	done
;;

2)
	dialog --inputbox "¿Que máquina desea borrar? $(virsh list --all)" 0 0 2>fich9
	borrar=$(cat fich9);rm -r fich9
	
	virsh destroy $borrar >/dev/null
	virsh undefine $borrar >/dev/null
	rm -r /var/lib/libvirt/images/$borrar.qcow2 >/dev/null
;;


3)
	clear;exit
;;


*)
	clear;exit
;;
esac
}

funcionComprobacionRoot
funcionComprobacionKVM

opcion=0
while [ $opcion -lt 4 ]
do
	funcionMenu
	funcionAccionesMenu $opcion
done


	
	
	
	
