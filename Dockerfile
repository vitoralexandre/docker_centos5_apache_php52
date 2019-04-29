FROM centos:6
MAINTAINER vitor.alexandre.tec.info@gmail.com 

# Volumes 
volumes:
  - /opt/templates:/opt/templates
  - /var/log/httpd:/var/log/httpd
  - /etc/passwd:/etc/passwd
  - /etc/shadow:/etc/shadow
  - /etc/group:/etc/group

# Installing epel
RUN yum install -y epel-release

# Updating 
RUN yum update -y 

# Installing support packages 
RUN yum install -y wget links

# Installing Apache 
RUN yum install -y httpd

# Installing PHP, libs em modules
RUN yum install -y php php-gd php-imap php-mysql php-pgsql php-mssql php-soap php-xml php-pdo php-mcrypt php-mbstring php-pear php-cli php-process php-intl php-pecl-memcache mod_suphp

# Installing postfix 
RUN yum install -y postfix 

# Installing logrotate 
RUN yum install -y logrotate

# Removing unnecessary files
RUN rm -f /etc/httpd/conf.d/welcome.conf
RUN rm -f /etc/httpd/conf.d/php.conf 
RUN rm -f /etc/suphp.conf
RUN rm -f /etc/httpd/conf/httpd.conf
RUN rm -f /etc/httpd/conf.d/suphp.conf
RUN rm -f /etc/logrotate.d/httpd
RUN rm -f /etc/httpd/conf.d/ssl.conf

# Adding Confs 
ADD conf/etc_suphp.conf /etc/suphp.conf
ADD conf/httpd.conf /etc/httpd/conf/httpd.conf
ADD conf/suphp.conf /etc/httpd/conf.d/suphp.conf
ADD conf/rotate_httpd  /etc/logrotate.d/httpd
ADD conf/ssl.conf /etc/httpd/conf.d/ssl.conf

# Creating template files
RUN mkdir /opt/templates 
ADD conf/vhost.conf /opt/templates/vhost.conf
ADD conf/vhost_ssl.conf /opt/templates/vhost_ssl.conf

CMD ["/usr/sbin/apachectl start && postfix start"]

