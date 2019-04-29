# Docker CentOS 6 with Apache and PHP 5.3

Docker with Apache 2.2 and PHP 5.3 executing suPHP. 

## Instructions 
- Clone this git repo: 
```
git clone https://github.com/vitoralexandre/docker_centos6_apache_php53.git
```


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
* NAME is image name. Ex.: 
```
docker build -t ph53 .
```

Then: 
```
# docker image ls 
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
php53               latest              a97b9c25b0c8        2 minutes ago       1.13GB
centos              6                   d0957ffdf8a2        6 weeks ago         194MB
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
docker run -it -d --restart=unless-stoped --network=host -v /opt/templates:/opt/templates -v /var/log/httpd:/var/log/httpd --mount type=bind,source=/etc/passwd,target=/etc/passwd --mount type=bind,source=/etc/shadow,target=/etc/shadow --mount type=bind,source=/etc/group,target=/etc/group --name NAME IMAGENAME 
```

- With port bind: 
```
docker run -it -d --restart=unless-stoped -p 80:80 -p 443:443 -v /opt/templates:/opt/templates -v /var/log/httpd:/var/log/httpd --mount type=bind,source=/etc/passwd,target=/etc/passwd --mount type=bind,source=/etc/shadow,target=/etc/shadow --mount type=bind,source=/etc/group,target=/etc/group --name NAME IMAGENAME
```
