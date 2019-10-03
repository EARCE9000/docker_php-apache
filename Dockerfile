FROM centos:7.6.1810

RUN yum -y install epel-release \
&& yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm \
&& yum-config-manager --disable remi-safe \
&& yum-config-manager --enable remi-php73 \
&& yum --enablerepo=remi -y install oniguruma5 \
&& yum --enablerepo=remi -y install gd-last \
&& yum --enablerepo=remi -y install libzip5 \
&& yum -y install httpd php php-mbstring php-gd php-xml php-xmlrpc php-soap php-json php-pdo php-mysqlnd php-pecl-zip \
&& yum -y update \
&& yum clean all

RUN /bin/mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.origin \
&& /bin/sed -e "s/logs\/access_log/\/dev\/stdout/" -e "s/logs\/error.log/\/dev\/stderr/" /etc/httpd/conf/httpd.conf.origin > /etc/httpd/conf/httpd.conf

EXPOSE 80

CMD ["/usr/sbin/httpd","-DFOREGROUND"]
