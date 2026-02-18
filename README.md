https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu



https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04


# create a non-root user.


# enable ssh

create a private/pub key.

`ssh-keygen -t rsa -b 4096 -C "s.teunissen@gmail.com"`
(choose an identity. in this case `dietpi`)

copy the key to the dietpi

`ssh-copy-id -i ~/.ssh/dietpi dietpi@192.168.188.156`

disable password login

/etc/ssh/sshd_config
PasswordAuthentication no
