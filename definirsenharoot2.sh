#!/bin/bash
# Nego Não Sabe Entrar Como Usuário Root
clear
[[ "$(whoami)" != "root" ]] && {
	clear
	echo -e "\033[1;31mVocê Não está como usuário ROOT digite \n\033[1;32m(\033[1;33m sudo -i \033[1;32m)\n\033[1;32mE insira o comando novamente \n"
	exit
}
[[ $(grep -c "prohibit-password" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/prohibit-password/yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "without-password" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/without-password/yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "#PermitRootLogin" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/#PermitRootLogin/PermitRootLogin/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "PasswordAuthentication" /etc/ssh/sshd_config) = '0' ]] && {
	echo 'PasswordAuthentication yes' > /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "PasswordAuthentication no" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "#PasswordAuthentication no" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/#PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
} > /dev/null
service ssh restart > /dev/null
iptables -F
clear && echo -ne "\033[1;32m Digite Sua Nova Senha Root\033[1;37m: "; read senha
[[ -z "$senha" ]] && {
echo -e "\n\033[1;31mCalma, Vê Se Não Erra De Novo\033[0m"
exit 0
}
echo "root:$senha" | chpasswd
echo -e "\n\033[1;31m[ \033[1;33mSenha Definida Com Sucesso \033[1;31m]\033[0m \n"
