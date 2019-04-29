# Docker CentOS 6 with Apache and PHP 5.3

Docker with Apache 2.2 and PHP 5.3 executing suPHP. 

## Instructions 
- Create dir for web sites files: 
```
mkdir /virtual
```

- Create dir for template files: 
```
mkdir /opt/templates
```

- Create dir for Apache logs: 
```
mkdir /var/log/httpd
```

- Build Dockerfile 
```
docker build -t NAME . 
```

## Creating VHOSTs
- Add user and change password:
```
useradd FTPUSER
passwd FTPUSER
```

- Copy template and edit it: 
```
cp -pavu /opt/templates/vhost.conf /tmp/DOMAIN.conf
sed -i "s/DOMAIN/domain.name/g" /tmp/DOMAIN.conf
sed -i "s/USER/ftpuser/g" /tmp/DOMAIN.conf 
sed -i "s/GROUP/ftpuser/g" /tmp/DOMAIN.conf 
mkdir -p /virtual/domain.name/www 
chown -R ftpuser.ftpuser /virtual/domain.name 
docker cp /tmp/DOMAIN.conf CONTAINERNAME:/etc/httpd/conf.d/
docker exec -it CONTAINERNAME apachectl -t 
```

If everything is ok, then: 
```
docker exec -it CONTAINERNAME apachectl graceful
```

SSL hosts uses file /opt/templates/vhost_ssl.conf and set SSL path is necessary. 

## Usage
- With host network: 
```
docker run -it -d --restart=unless-stoped --network=host --name NAME IMAGENAME 
```

- With port bind: 
```
docker run -it -d --restart=unless-stoped -p 80:80 -p 443:443 --name NAME IMAGENAME
```

All volumes was mounted on Dockerfile. 

