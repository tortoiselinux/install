#!/bin/bash
##########################################################
# Scripts de Exemplo para design do installador          #
# Obs: esse script não faz nenhuma etapa real            #
#      de instalação.                                    #
#                                                        #
#                                                        #
# Autor: Wellyton Barbosa Galdino                        #
# Licenca: MIT                                           #
##########################################################

#set -ex

verify_and_source(){
    local FILEPATH="$1"
    [[ -f "$FILEPATH" ]] && source "$FILEPATH"
}

source_or_create(){
    local FILEPATH="$1"
    [[ -f "$FILEPATH" ]] || touch "$FILEPATH"
    source "$FILEPATH"
}

[[ -v INSTALLFILE ]] || INSTALLFILE="./tortoise_installer/install.conf"

verify_and_source ../profile/airootfs/etc/tortoise/tortoise_installer/lib.sh

write_env_var(){
    local KEY="$1"
    local VALUE="$2"
    local FILE="$3"
    echo "$KEY=\"$VALUE\"" >> "$FILE"
}

case $1 in
    f | -f | file | --file)
	print "$2"
        INSTALLFILE="$2"
	;;
    u | -u | update | --update)
	print "updating installer"
	exit 0
	;;
esac

source "$INSTALLFILE"

get_efi(){
    EFI=$(dialog --stdout --title "PARTICIONAMENTO" --menu "Selecione a partição EFI" 0 0 0 \
		 $(lsblk -ln -o NAME,TYPE,SIZE | awk '$2=="part" {print "/dev/" $1 " " $3}'))
}

get_root(){
    ROOT=$(dialog --stdout --title "PARTICIONAMENTO" --menu "Selecione a partição de ROOT " 0 0 0 \
		  $(lsblk -ln -o NAME,TYPE,SIZE | awk '$2=="part" {print "/dev/" $1 " " $3}'))
}

get_swap(){
    SWAP=$(dialog --stdout --title "PARTICIONAMENTO" --menu "Selecione a partição SWAP" 0 0 0  \
		  $(lsblk -ln -o NAME,TYPE,SIZE | awk '$2=="part" {print "/dev/" $1 " " $3}'))    
}

get_home(){    
    #DEF_HOME=$(dialog --stdout --title "PARTICIONAMENTO" --yesno "Deseja definir a partição HOME?" 0 0)
    USERHOME=$(dialog --stdout --title "PARTICIONAMENTO" --menu "Selecione a partição HOME" 0 0 0 \
		  $(lsblk -ln -o NAME,TYPE,SIZE | awk '$2=="part" {print "/dev/" $1 " " $3}'))
}


get_net_packages(){
    INTERNET=$(dialog --stdout --title "INTERNET" --checklist 'Softwares para navegar na rede' 0 0 0 \
		      firefox '' on \
		      qute 'browser' off \
		      qbittorrent '' off \
		      chromium '' off \
		      thunderbird '' off \
		      discord '' off
	    )
}

get_devtools_packages(){
    DEVTOOLS=$(dialog --stdout --title "DEVTOOLS" --checklist 'Ferramentas para desenvolvimento' 0 0 0 \
	              emacs '' on \
		      gnome-boxes '' off \
		      vim '' off \
		      neovim '' off \
		      micro '' on \
		      code '(Visual Studio Code)' off \
		      leafpad '' off \
		      nano '' off
	    )    
}
get_languages_packages(){
    LANGUAGES=$(dialog --stdout --title "LINGUAGENS E COMPILADORES" \
		       --checklist 'Escolha quais linguagens devem ser instaladas' 0 0 0 \
		       lua '' on \
		       python '' off \
		       ruby '' off \
		       go '' off \
		       rustup '(rust installer)' off \
		       nodejs '(JavaScript)' off \
		       zig '' off \
		       php '' off
	     )    
}

# get_and_write(){
#     get_userpasswd && write_env_var "USERPASSWD" "$selected_userpasswd"
# }

# [[ -n "${USERPASSWD-}" ]] || get_and_write

# depois dos testes, concluo que para essa feature dos dados em arquivo
# utilizar: `[[ -v EFI ]] || get_efi` (com o write_env_var dentro da função get)
# e `[[ -v ROOT ]] || (get_root && write_env_var "ROOT" "$ROOT")`
# resolve o problema da reescrita de variáveis

# [[ -v EFI ]] || get_efi

[[ -v USERPASSWD ]] || (get_userpasswd && write_env_var "USERPASSWD" "$USERPASSWD" "$INSTALLFILE")
[[ -v EFI ]] || (get_efi && write_env_var "EFI" "$EFI" "$INSTALLFILE")
[[ -v ROOT ]] || (get_root && write_env_var "ROOT" "$ROOT" "$INSTALLFILE")
[[ -v SWAP ]] || (get_swap && write_env_var "SWAP" "$SWAP" "$INSTALLFILE")
[[ -v USERHOME ]] || (get_home && write_env_var "USERHOME" "$USERHOME" "$INSTALLFILE")
[[ -v INTERNET ]] || (get_net_packages && write_env_var "INTERNET" "$INTERNET" "$INSTALLFILE")
[[ -v DEVTOOLS ]] || (get_devtools_packages && write_env_var "DEVTOOLS" "$DEVTOOLS" "$INSTALLFILE")

verify_and_source "$INSTALLFILE"

print "USERPASSWD: $USERPASSWD"
print "EFI: $EFI"
print "ROOT: $ROOT"
print "SWAP: $SWAP"
print "USERHOME: $USERHOME"
print "INTERNET: $INTERNET"
print "DEVTOOLS: $DEVTOOLS"

#cat ./tortoise_installer/install.conf
