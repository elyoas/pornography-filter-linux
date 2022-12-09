![SatanLovesP](SatanLovesP.png "SatanLovesP")

# A very effective Catholic holy armour (firewall filter) to block pornography

*Lust is one of the seven cardinal vices.*

*«If your right eye causes you to stumble, gouge it out and throw it away. It is better for you to lose one part of your body than for your whole body to be thrown into hell. And if your right hand causes you to stumble, cut it off and throw it away. It is better for you to lose one part of your body than for your whole body to go into hell.» (Matthew 5:29-30)*

*«And Jesus entered the temple of God and drove out all who sold and bought in the temple, and he overturned the tables of the money-changers and the seats of those who sold pigeons.» (Matthew 21:12)*

*«Anyone who looks at a woman to lust after her has already committed adultery with her in his heart.» (Matthew 5:28)*

*«You shall not covet your neighbor’s wife.» (Deuteronomy 5:21)*

*«Submit yourselves, then, to God. Resist the devil, and he will flee from you.» (James 4:7)*

*«But each one is tempted when by his own evil desires he is lured away and enticed.» (James 1:14)*

*«Put on the full armor of God, so that you can take your stand against the devil’s schemes.» (Ephesians 6:11)*

### About:
- This is the most effective method of blocking pornography that I have ever achieved (word origin: porneia πορνεία, meaning "prostitution", _britannica_ definition).
- The best way not to commit evil, is to avoid it, to stay far from it, and to make it difficult to reach.
- The filter blocks everything except a predefined whitelist of _domains_. It forces all http/https traffic to pass through a proxy, which acts as the filter. It can be used to protect your family, or to rid yourself from addiction.
- e2guardian project is forked from https://github.com/e2guardian/e2guardian
- The filter is preconfigured to be in ` walled garden ` mode.
- Powerful regular expression blocking [bannedregexpurllist]
- Please ask me for help, I will help you, God willing. Please help me improve this filter so that we can protect the innocense and purity of children.
- Blocking 3 letter words is dangerous; as it breaks youtube silently
- Advantage over squid: SSL url regex replacement.
- difference between blocking using hosts file and bannedsitelist is that the websites on bannedsitelist block included subdomains. whereas on hosts file, it blocks only the specified domain only. EXCELLENT!

### Articles:
https://fightthenewdrug.org/why-porn-can-be-difficult-to-quit/
https://www.thecatholicthing.org/2021/11/30/pornography-and-the-castration-of-young-men/
https://www.thecatholicthing.org/2018/06/25/satan-loves-porn/

## How to setup:
*1. Build e2guardian from source according to the instructions below*

*2. Copy all e2g files*

`cd ./new_v5.4.4 && sudo make`

*3. Setup firewall (iptables rules)*

`./script1_activate_firewall.sh`

*4. Force all traffic go through e2guardian port (iptables)*

`./script2_activate_e2guardian.sh`

*5. Set all of your applications to use proxy, and add 'ca.pem' certificate to firefox/chromium/arch*

`127.0.0.1:8080`

*6. Create a random sudo password, and prevent your current user from changing or accessing any super user authority. This is to prevent disabling the filter.*
```
sudo vim /etc/sudoers
Defaults targetpw # (uncomment this line)
# now change root password by:
sudo passwd root # Hail Mary
```

## TODO:
- setup e2guardian on AWS (DNS or,and VPN), then create an app which forces connection (VPN usage) just like bulldog filter + encryption

  https://aws.amazon.com/marketplace/pp/prodview-gzywopzvznrr4
  
  https://safe.duckduckgo.com/?q=aws+with+pfsense&ia=web
  
X - make banned sites (put them from hosts file) override all exception sites (override all .com/.org..)
- (old) enable [exceptionlists] to be filtered using [bannedurllist] using story files? (see site.story)
- (old) shortage: I want to allow a domain, but blacklist a url within that domain (only in a whitelisted mode. whereas in normal mode, I can block google search).
X - ban all websites on bannedsiteslist
- get the bannedtimes lists working (all domains allowed during the day)
X - set it so that the safe search is always enforced

## e2g Regex engine:
https://groups.google.com/g/e2guardian/c/HbfwEbCwgRw
E2guardian uses the PCRE library. You can try out and debug expressions out using https://regex101.com or one of the other regexp checkers available.

## Installation of e2guardian (5.4.4r):

#### 1. Build (on Archlinux & ubuntu):
`sudo killall e2guardian # x2`

`./autogen.sh`

`./configure --help`

`./configure '--enable-clamd=yes''--with-proxyuser=e2guardian' '--with-proxygroup=e2guardian' '--enable-icap=yes' '--enable-commandline=yes' '--enable-email=yes' '--enable-ntlm=yes' '--enable-pcre=yes' '--enable-sslmitm=yes' # options are taken from INSTALL file, debian section`

```
# now edit the following line in: ./e2config.h:
# From:
#define __CONFFILE "${prefix}/etc/e2guardian/e2guardian.conf"
# To:
#define __CONFFILE "/usr/local/etc/e2guardian/e2guardian.conf"
# This fixes error: Error opening ${prefix}/etc/e2guardian/e2guardian.conf
```

`make -j 2`

`sudo make install`

`cd configs`

`make`

`sudo make install`

#### 2. create new user:
`sudo useradd -r -s /usr/bin/nologin e2guardian # create user. on ubuntu: sudo useradd -r -s /usr/bin/bash e2guardian`

`sudo chown -R nobody:nobody /usr/local/var/log/e2guardian/ # sudo e2guardian won't run otherwise (must be root). try remove last '/' if it does not work. if it does not work on ubuntu try: sudo chown -R nobody. /usr/local/var/log/e2guardian/`

**IMPORTANT:** ALL config files must not have any CRLF characters.
If you have error with config files when running `sudo systemctl status e2guardian`, it is because of CRLF chars; replace them with LF chars using:

`     sed -e $'s|\r||g' -i ./e2guardian.conf`
`sudo sed -e $'s|\r||g' -i /usr/local/var/log/e2guardian/access.log`

#### 3. enable service:
`sudo cp /usr/local/share/e2guardian/scripts/e2guardian.service /usr/lib/systemd/system/e2guardian.service`

`sudo killall e2guardian # x2. or: sudo e2guardian -q`

`sudo systemctl enable e2guardian`

`sudo systemctl start e2guardian`

`sudo systemctl status e2guardian # or: systemctl status e2guardian.service`

`sudo systemctl daemon-reload`

#### 4.  install certificates:
`sudo mkdir /usr/local/etc/e2guardian/private`

`cd /usr/local/etc/e2guardian/private`

`# caprivatekeypath = '/usr/local/etc/e2guardian/private/ca.key'`

`sudo bash -c "openssl genrsa 4096 > ca.key"`

`# cacertificatepath = '/usr/local/etc/e2guardian/private/ca.pem'`

`sudo openssl req -new -x509 -days 3650 -key ca.key -out ca.pem # add it to ffx/chromium`

`# certprivatekeypath = '/usr/local/etc/e2guardian/private/cert.key'`

`sudo bash -c "openssl genrsa > cert.key"`

`sudo mkdir /usr/local/etc/e2guardian/private/generatedcerts/`

`sudo chown e2guardian: * # ubuntu: sudo chown e2guardian. .`

`# Copy certificate into firefox & chromium (certificates -> authorities):`

`cp /usr/local/etc/e2guardian/private/ca.pem ./`

#### 5. [UNNECESSARY]. not done on home pc.
daemonuser = 'nobody'
daemongroup = 'nobody'
sudo vim /usr/local/etc/e2guardian/e2guardian.conf

#### 6. Make pacman/youtube-dl work with the new certificate (on Archlinux):
`sudo cp my_rootCA.crt /etc/ca-certificates/trust-source/anchors`

`sudo update-ca-trust`

Fix apt-get on Ubuntu: 

`sudo visudo # then add below Defaults env_reset`

`Defaults env_keep = "http_proxy ftp_proxy" # works but use below instruction instead`

`Defaults env_keep = "http_proxy https_proxy ftp_proxy DISPLAY XAUTHORITY" # this is to fix graphical x11 utilities`
https://askubuntu.com/questions/7470/how-to-run-sudo-apt-get-update-through-proxy-in-commandline

#### 7. Watch the log: (Use it for troubleshooting)

`tail -f /usr/local/var/log/e2guardian/access.log # | egrep www.youtube.com`

`tail -f /usr/local/var/log/e2guardian/access.log | grep -iE "NETERROR|denied|URLMOD|https://|http://|$"`

#### help resources:
- https://help.ubuntu.com/community/DansGuardian
- https://serverfault.com/questions/1020775/e2guardian-block-url-in-whitelisted-domain
- https://askubuntu.com/questions/1248770/e2guardian-block-url-in-whitelisted-domain
- https://groups.google.com/forum/#!topic/e2guardian/DU6FVi97ztE
- https://github.com/e2guardian/e2guardian/issues/603
- https://github.com/e2guardian/e2guardian/issues/604
- https://www.youtube.com/watch?v=jPqjEgF49Uo
- https://github.com/awesomeWM/awesome/issues/3113
- https://github.com/awesomeWM/awesome/issues/3112

- https://bbs.archlinux.org/viewtopic.php?id=256499

#### delete e2g (installation paths):
`sudo rm -rf /usr/local/etc/e2guardian`
`sudo rm -rf /usr/local/var/log/e2guardian`
`sudo rm -rf /usr/local/share/e2guardian`
`sudo rm /usr/lib/systemd/system/e2guardian.service`

#### Fix error 1:
If you have error ` sudo: unable to resolve host elias-Mimetrik: Temporary failure in name resolution`
Add ` 127.0.0.1 elias-Mimetrik` to ` /etc/hosts`

#### Fix error 2: Check the group that e2guardian runs as (nobody)
```
ls -a1l /usr/local/var/log/e2guardian/access.log
sudo chown -R nobody:nobody /usr/local/var/log/e2guardian/access.log # if it gives: chown: invalid group: ‘nobody:nobody’ then the group does not exist
sudo groupadd nobody # create group
sudo usermod -a -G nobody nobody # add user to group; if the user does not exist, see above how to create it
sudo chown -R nobody:nobody /usr/local/var/log/e2guardian/access.log
sudo touch /usr/local/var/log/e2guardian/request.log # if it is missing
sudo chown -R nobody:nobody /usr/local/var/log/e2guardian/request.log
sudo chown -R nobody:nobody /usr/local/var/log/e2guardian/dstats.log
sudo chmod 755 /usr/local/var/log/e2guardian
sudo chmod 744 /usr/local/var/log/e2guardian/*
```
