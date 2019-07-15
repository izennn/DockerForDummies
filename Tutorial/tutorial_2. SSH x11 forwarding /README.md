## SSH into the instance and show display the application.

Install ssh on server (container)

`apt-get install openssh-server`

#####Set the server config

etc/ssh/sshd_config:

```
X11Forwarding yes
X11UseLocalhost no
```

```
sudo ufw allow 22
sudo service ssh restart
```


client side

`ssh <-X> <-Y> <-v> <-p PORT> $PORT_USER@IP`

for general  server <-X>

for trusted server (pc / instance) <-Y>

`-Y` allow you do some security configuration if both sides are in trusted whitelist

    ssh -X  -p 53022 keras@192.168.1.69


##### (OPTIONAL) Depends on the server and client sides 

If the ssh image doesn’t have the Xorg , you may install the GUI into server container

Server:

`sudo apt-get install xorg`

Clent:

`sudo apt-get install xauth`

<br/>

#### Remarks
MAC user may use [Xquartz](https://www.xquartz.org), the way to forward the X11 to Mac

---