#!/bin/bash

function equipos() {
which ifconfig && { echo "Comando ifconfig existe...";
	direccion_ip=`ifconfig |grep inet | grep -v "127.0.0.1" |awk '{ print $2}'`;
	echo " Esta es tu direccion ip: "$direccion_ip;
        subred=`ifconfig |grep inet |grep -v "127.0.0.1" |awk '{ print $2}'|awk -F. '{print $1"."$2"."$3"."}'`;
        echo " Esta es tu subred: "$subred;
		  }\
	     ||  { echo "No existe el comando ifconfig... usando ip ";
		   direccion_ip=`ip addr show |grep inet | grep -v "127.0.0.1" |awk '{ print $2}'`;
		   echo " Esta es tu direccion ip: "$direccion_ip;
		   subred=`ip addr show |grep inet | grep -v "127.0.0.1" |awk '{ print $2}'|awk -F. '{print $1"."$2"."$3"."}'`;
		   echo " ESta es tu subred: "$subred;
		  }
	for ip in {1..254}
	do
		ping -q -c 4 ${subred}${ip} > /dev/null
		if [ $? -eq 0 ]
		then
			echo "Host responde: " ${subred}${ip}
		fi
     	done
      }

function puertos() {
echo "Introduzca una direccion ip: "
read direccion_ip
puertos="20,21,22,23,24,25,50,51,53,80,110,119,135,136,137,138,139,143,161,162,389,443,445,636,1025,1443,3389,5985,5986,8080,10000"
[ $# -eq 0 ] && { echo "IP Invalida"; exit 1; }
IFS=,
for port in $puertos
do
	timeout 1 bash -c "echo > /dev/tcp/$direccion_ip/$port > /dev/null 2>&1" &&\
	echo $direccion_ip";"$port" is open"\
	||\
	echo $direccion_ip":"$port" is closed"
   done
}

function info() {
	echo "Username: "
	whoami	
	echo "Hostname: "
	hostname
	echo "Sistema Operativo: "
	uname
}

menu() {

echo `date`
echo -ne "
-*-*-*-*-*-*-*-*-*-*
   Menu de Inicio  
-*-*-*-*-*-*-*-*-*-*
 1) Escaneo de equipos activos
 2) Escaneo de puertos
 3) Mostrar informacion
 4) Salir
"
read a
case $a in
	1) equipos ; menu ;;
	2) puertos ; menu ;;
	3) info ; menu ;;
	4) exit 0 ;;
esac
}

menu
