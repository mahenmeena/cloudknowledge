FROM centos:latest
MAINTAINER mahendrajboss@gmail.com
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum install -y httpd \
  zip \
unzip
ADD https://files.all-free-download.com/downloadfiles/graphic/graphic_7/green_energy_website_template_6891385.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip green_energy_website_template_6891385.zip
RUN cp -rvf template/* .
RUN rm -rf template preview green_energy_website_template_6891385.zip
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
