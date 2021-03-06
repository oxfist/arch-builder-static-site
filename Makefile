.PHONY: hostname
hostname:
	sh bin/hostname.sh

.PHONY: locales
locales:
	sh bin/locales.sh

.PHONY: network
network:
	sh bin/network.sh

.PHONY: time
time:
	sh bin/time.sh

.PHONY: packages
packages:
	sh bin/packages.sh

pam:
	echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su
	echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su-l

.PHONY: users
users:
	sh bin/users.sh

shutdown:
	cp etc/shutdown /usr/local/bin/shutdown
	chmod +x /usr/local/bin/shutdown

securetty:
	echo "hvc0" > /etc/securetty

.PHONY: services
services:
	systemctl enable logrotate
	systemctl start logrotate
	systemctl enable nftables
	systemctl enable systemd-timesyncd
	systemctl set-default multi-user.target

sshd:
	cp etc/sshd /etc/sshd_config

sudoers:
	cp etc/sudoers /etc/sudoers

syslinux:
	syslinux-install_update -iam
	cp etc/syslinux.cfg /boot/syslinux/syslinux.cfg

systemd-boot:
	bootctl --path=/boot install
	cp etc/loader.conf /boot/loader/loader.conf
	cp etc/arch.conf /boot/loader/entries/arch.conf

# Main stuff

.PHONY: production
production: hostname locales packages pam securetty services sshd sudoers syslinux time users
	timedatectl set-ntp true
