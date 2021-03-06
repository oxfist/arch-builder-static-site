#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "Now enter new root password."
passwd

useradd --system\
	--create-home\
	--user-group\
	--shell /usr/bin/nologin backups

chmod 750 /home/backups

while :
do
	echo "Enter username:"
	read USERNAME
	if [[ -n "${USERNAME}" ]]; then
		useradd -m -G wheel -s /bin/bash ${USERNAME}
		gpasswd -a "${USERNAME}" backups
		echo "Now enter a password for the new user."
		passwd ${USERNAME}
		break
	fi
done

mkdir /home/${USERNAME}/.ssh
cp key.pub /home/${USERNAME}/.ssh/authorized_keys
chmod 400 /home/${USERNAME}/.ssh/authorized_keys
chmod 700 /home/${USERNAME}/.ssh
chown ${USERNAME}: -R /home/${USERNAME}/.ssh
chattr +i /home/${USERNAME}/.ssh/authorized_keys
chattr +i /home/${USERNAME}/.ssh
