FROM centos:6
MAINTAINER vitor.alexandre.tec.info@gmail.com 

# Installing epel
RUN yum install -y epel-release

# Installing RPMforge 
RUN yum install -y http://ftp.tu-chemnitz.de/pub/linux/dag/redhat/el6/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm 

# Updating 
RUN yum update -y 

# Installing support packages 
RUN yum install -y wget links

# Installing Apache 
RUN yum install -y httpd mod_ssl

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
ADD conf/httpd_suphp.conf /etc/httpd/conf.d/suphp.conf
ADD conf/rotate_httpd  /etc/logrotate.d/httpd
ADD conf/ssl.conf /etc/httpd/conf.d/ssl.conf

# Creating template files
RUN mkdir /opt/templates 
ADD conf/vhost.conf /opt/templates/vhost.conf
ADD conf/vhost_ssl.conf /opt/templates/vhost_ssl.conf

CMD ["httpd", "-DFOREGROUND"]
