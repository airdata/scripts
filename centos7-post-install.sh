#!/usr/bin/env bash
#
# TO DO:
# -- Revamp passwd formatting
#   --- Handle Exception outputs
#   --- Maybe use TUI instead
# -- Make script autorun once USB is plugged in
# -- Identify network interface for stalling


##############################################################################################################
# VARIABLES
##############################################################################################################
red=$(tput setaf 1)$(tput bold)
green=$(tput setaf 2)$(tput bold)
orange=$(tput setaf 3)$(tput bold)
reset=$(tput sgr0)

empty="[      ]"
fail="[${red}FAILED${reset}]"
ok="[  ${green}OK${reset}  ]"
no="[  ${red}NO${reset}  ]"


##############################################################################################################
# Begin Post-Install Script
##############################################################################################################
printf "${green}Starting CentOS 7 SFTP Server Post-Installation Script...${reset}\n\n"


##############################################################################################################
# Check Firewall for SSH
##############################################################################################################
printf "${empty}: Checking SSH...\n"

if [[ $(netstat -tulpn 2>/dev/null | grep '22') ]]; then
  tput cuu1; tput el
  printf "${ok}: SSH is On.\n"
else
  for i in $(seq 0 1); do
    if [ "${i}" == 0 ]; then
      tput cuu1; tput el
      systemctl restart sshd.service
      printf "${empty}: Restarting SSH...\n"
      sleep 2
      if [[ $(netstat -tulpn 2>/dev/null | grep '22') ]]; then
        tput cuu1; tput el
        printf "${ok}: SSH in On.\n"
      fi
    else
      tput cuu1; tput el
      printf "${no}: SSH is Off.\n"
    fi
  done
fi


##############################################################################################################
# Create Groups
##############################################################################################################
printf "${empty}: Creating 'sftpusers' Group...\n"
groupadd sftpusers
tput cuu1; tput el
printf "${ok}: Created 'sftpusers' Group.\n"


##############################################################################################################
# Create Admin
##############################################################################################################
printf "${empty}: Creating 'admin' Account...\n"

useradd admin
passwd admin
usermod -aG wheel admin
sed -i '0,/wheel/{s/# %wheel/\%wheel/}' /etc/sudoers

for i in $(seq 0 4); do tput cuu1; tput el; done
printf "${ok}: Created 'admin' Account.\n"

##############################################################################################################
# Create Users
##############################################################################################################
printf "${empty}: Creating Users...\n"

printf "          ${orange}Enter username: ${reset}"
read username
username=$(echo ${username})

useradd ${username}
passwd ${username}

for i in $(seq 0 5); do tput cuu1; tput el; done
printf "${ok}: Created '${username}' Account.\n"


##############################################################################################################
# SSH Keys
##############################################################################################################
printf "${empty}: Generating SSH Keys...\n"

while true; do
printf "          ${orange}Please Generate/Copy Keys On Host [ENTER when done]: ${reset}"
  read confirmation
  confirmation=$(echo ${confirmation})

  if [ ! -d "/home/${username}/.ssh" ]; then
    for (( i=0; i<2; i++ )); do tput cuu1; tput el; done
    printf "${no}: Generated SSH keys.\n"
  else
    break
  fi
  sleep 1
done

for (( i=0; i<2; i++ )); do tput cuu1; tput el; done
printf "${ok}: Generated SSH keys.\n"


##############################################################################################################
# Chroot
##############################################################################################################
printf "${empty}: Creating Chroot Directories...\n"

mkdir -p /sftp/${username}/files
usermod -g sftpusers -d /sftp/${username} ${username}

tput cuu1; tput el
printf "${ok}: Created Chroot Directories.\n"


##############################################################################################################
# Permissions
##############################################################################################################
printf "${empty}: Changing Chroot Permission...\n"

chown ${username}:sftpusers /sftp/${username}/files
chmod 755 /sftp/${username}
mv /home/${username}/.ssh/ /sftp/${username}
chmod 600 /sftp/${username}/.ssh/authorized_keys
chsh -s /sbin/nologin ${username}

for (( i=0; i<3; i++ )); do tput cuu1; tput el; done
printf "${ok}: Changed Chroot Permission.\n"


##############################################################################################################
# SSH Hardening
##############################################################################################################
printf "${empty}: Hardening SSH Configuration...\n"

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
printf "\nAllowGroups sftpusers\n" >> /etc/ssh/sshd_config

tput cuu1; tput el
printf "${ok}: Hardened SSH Configuration.\n"


##############################################################################################################
# SFTP
##############################################################################################################
printf "${empty}: Configuring SFTP...\n"

sed -i 's/Subsystem/#Subsystem/' /etc/ssh/sshd_config
sed -i '/#Subsystem/aSubsystem       sftp    internal-sftp' /etc/ssh/sshd_config

printf "\nMatch Group sftpusers
  ChrootDirectory /sftp/%u
  ForceCommand internal-sftp
  X11Forwarding no
  AllowTcpForwarding no\n" >> /etc/ssh/sshd_config

tput cuu1; tput el
printf "${ok}: Configured SFTP.\n"


##############################################################################################################
# Stalling
##############################################################################################################
printf "${empty}: Preventing Stalling...\n"

printf "          Do you want to prevent stalling? [y/n] "
read confirmation
confirmation=$(echo ${confirmation} | tr "[:lower:]" "[:upper:]")

if [[ ${confirmation} == "YES" || ${confirmation} == "Y" ]]; then
  ifconfig wlp1s0b1 mtu 1490
fi

for (( i=0; i<3; i++ )); do tput cuu1; tput el; done
printf "${ok}: Prevented stalling.\n"


##############################################################################################################
# Restart SSH
##############################################################################################################
printf "${empty}: Restarting SSH...\n"
systemctl restart sshd.service
tput cuu1; tput el
printf "${ok}: Restarted SSH...\n"


##############################################################################################################
# Success
##############################################################################################################
printf "${green}\nCentOS 7 SFTP Server Post-Installation Script Complete!\n\n${reset}"

