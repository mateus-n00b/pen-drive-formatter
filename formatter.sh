#!/bin/bash
# Programa que realiza a formatacao de um dispositivo de armazenamento utilizando o programa mkfs.vfat
#
# Mateus, Agosto 2016
#
# Versao 1.0
#
# Licenca GPL
# 
#-========================================================================================================-
 
pen=$(df | grep -i media | awk -F" " '{print $6}')
devs=$(df | grep -i media | awk -F" " '{print $1}')
echo "[!] Voce tem os seguintes dispositivos:"
cont=0

for x in "${pen[@]}"
do
    echo "$cont - $x"
    let cont++
done

read -p "[!] Escolha o dispositivo a ser formatado: " ind
[ -z "$ind" ] && echo "Entrada invalida! Saindo..." && exit 1

if ! bc <<< 1+"$ind" &> /dev/null  
then
	 echo "Entrada invalida! Saindo..." 
	 exit 1
fi

if grep "${devs[$ind]}" <<< "${devs[@]}" &> /dev/null
then
	echo "[!] Voce escolheu o dispositivo ${pen[$ind]}"
	echo "[!] Podera ser necessario inserir a senha de root ou sudo "
	umount "${pen[$ind]}"
	sudo mkfs.vfat "${devs[$ind]}"
	echo "[!] Formatando..."
	if [ $? -eq 0 ] 
	then	
		echo "[+] Operação realizada com sucesso! Retire e insira o dispositivo novamente." 
	else
		echo "[-] Erro! Tente mais tarde."
	fi
	
else
	echo "[-] Dispositivo invalido! Saindo..."
	exit 1
fi
