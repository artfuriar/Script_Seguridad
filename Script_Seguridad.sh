#PROGRAMA PARA VERIFICAR SEGURIDAD SISTEMA                                                                                                                                                                                                                                              #!/bin/bash

#Creo una función para la opción 4 que comprueba si nmap está instalado en el sistema, si no lo está, lo instala.

estanmap() {
echo -e " \033[01;96mMOSTRANDO PUERTOS ABIERTOS:\033[0m..."
        sudo nmap -sU -O localhost>/dev/null
        if [ $? -eq 0 ];
        then
        sudo nmap -sU -O localhost
        echo
        echo -e "\033[01;92m"
        read -p "Presione enter para volver al MENÚ"
        clear
else
        echo -e "\033[1;91mEs necesario instalar nmap\033[0m"
        read -p "Presione enter para instalar"
        sudo apt -y update
        sudo apt -y install nmap
        echo
        echo
        echo -e " \033[01;96mMOSTRANDO PUERTOS ABIERTOS: "
        sudo nmap -sU -O localhost
        echo
        echo -e "\033[01;92m"
        read -p "Presione enter para volver al MENÚ"
        clear
fi
    }

clear
echo
echo -e "==============================================================="
echo -e "\033[4;40;01;31mPROGRAMA DE CONSULTAS RELACIONADAS CON LA SEGURIDAD DEL SISTEMA\033[0m"
echo -e "==============================================================="
while :
do
echo
echo -e "==============================================================="
echo -e "\033[4;40;01;93m**********************-MENÚ DE OPCIONES:-**********************\033[0m"
echo -e "==============================================================="
echo
echo -e "1. \033[4;01;92mÚLTIMOS USUARIOS REGISTRADOS EN EL SISTEMA\033[0m"
echo -e "2. \033[4;01;92mFALLOS DE AUTENTICACIÓN EN ROOT\033[0m"
echo -e "3. \033[4;01;92mCOMPROBAR EL ESTADO DE LAS CONTRASEÑAS DE LOS USUARIOS\033[0m"
echo -e "4. \033[4;01;92mMOSTRAR PUERTOS ABIERTOS\033[0m"
echo -e "5. \033[4;01;92mCONEXIONES ACTIVAS EN INTERNET\033[0m"
echo -e "6. \033[4;01;92mFICHEROS .txt DEL DIRECTORIO /home MODIFICADOS EN LAS ÚLTIMAS 24 HORAS\033[0m"
echo -e "7. \033[4;01;31mSALIR\e[0m"
echo
echo -e " \033[01;93mPULSA UNA OPCIÓN:\033[0m"
echo
read entrada
  case $entrada in
     1)
        echo
        echo -e " \033[01;96mMOSTRANDO ÚLTIMOS USUARIOS REGISTRADOS EN EL SISTEMA...\033[0m "
        sleep 2
        sudo last -adFiw
        echo
        echo
        echo -e "\033[01;92m"
        read -p "Presione enter para volver al MENÚ"
        clear
     ;;
     2)
        echo -e " \033[01;96mMOSTRANDO LOS INTENTOS FALLIDOS A ROOT...\033[0m"
        echo
        cat /var/log/auth.log|grep "FAILED su*"
        if [ $? -ne 0 ];
        then
        echo -e "\033[01;34mNo se han registrado intentos fallidos a root\033[0m"
        fi
        echo
        echo -e "\033[01;92m"
        read -p "Presione enter para volver al MENÚ"
        clear
     ;;
     3)
        echo -e " \033[01;96mMOSTRANDO ESTADO DE LAS CONTRASEÑAS...\033[0m"
        echo
        echo -e "\033[01;31mNP-> SIN CONTRASEÑA\033[0m L-> CONTRASEÑA BLOQUEADA  y P-> CONTRASEÑA VÁLIDA"
        echo
        sudo passwd -Sa
        echo -e "\033[01;96m"
        read -p "Presione enter para ver los USUARIOS SIN CONTRASEÑA"
        echo -e "\033[01;31m"
        sudo passwd -Sa|grep 'NP'
        if [ $? -ne 0 ];
        then
        echo -e "\033[01;34mNo hay usuarios SIN CONTRASEÑA\033[0m"
        fi
        echo
        echo -e "\033[01;92m"
        read -p "Presione enter para volver al MENÚ"
        clear
     ;;
     4)
        estanmap //LLamo a la función
     ;;
     5)
        echo -e " \033[01;96mMOSTRANDO CONEXIONES ACTIVAS EN INTERNET...\033[0m"
        echo
        lsof -i -P -n
        if [ $? -ne 0 ];
        then
        echo -e "\033[01;34mNo hay conexiones activas en Internet\033[0m"
        fi
        echo
        echo -e "\033[01;92m"
        read -p "Presione enter para volver al MENÚ"
        clear
     ;;
     6)
        echo -e " \033[01;96mMOSTRANDO FICHEROS .txt DEL DIRECTORIO /home MODIFICADOS EN LAS ÚLTIMAS 24 HORAS...\033[0m"
        echo
        sudo find /home -type f -mtime -1 -exec ls -gGh --full-time '{}' \; | cut -d ' ' -f 4,5,7 | grep ".txt"
        echo
        echo -e "\033[01;92m"
        read -p "Presione enter para volver al MENÚ"
        clear
     ;;
     7)
        echo -e " \033[01;92mSALIENDO...\033[0m"
        sleep 1
        clear
        exit 1
     ;;

     *)
        echo -e " \033[01;91mOPCIÓN NO VÁLIDA: " 
     ;;
  esac
done
