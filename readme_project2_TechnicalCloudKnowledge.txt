11/09/22


FROM centos:latest
MAINTAINER mahendrajboss@gmail.com
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum install -y httpd \
  zip \
unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page247/kindle.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip kindle.zip
RUN cp -rvf markups-kindle/* .
RUN rm -rf _MACOSX markups-kindle kindle.zip
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80

*********
Jenkins
exec: rsync -avh /var/lib/jenkins/workspace/cloudknowledge-job/Dockerfile root@X.X.X.X:/opt

Ansible
exec: 
cd /opt
docker image build -t $JOB_NAME:v1.$BUILD_ID .
docker image tag $JOB_NAME:v1.$BUILD_ID mahenmeena/$JOB_NAME:v1.$BUILD_ID
docker image tag $JOB_NAME:v1.$BUILD_ID mahenmeena/$JOB_NAME:latest
docker image push mahenmeena/$JOB_NAME:v1.$BUILD_ID
docker image push mahenmeena/$JOB_NAME:latest
docker image rmi $JOB_NAME:v1.$BUILD_ID mahenmeena/$JOB_NAME:v1.$BUILD_ID mahenmeena/$JOB_NAME:latest


Ansible playbook docker.yml

- hosts: all
  tasks:
     - name: stop container
       shell: docker container stop cloudknowledge-container
     - name: remove container
       shell: docker container rm cloudknowledge-container
     - name: remove docker image
       shell: docker image rm mahenmeena/cloudknowledge-job
     - name: create container
       shell: docker container run -itd --name cloudknowledge-container -p 9000:80 mahenmeena/cloudknowledge-job

Post Build
ansible
exec: ansible-playbook /sourcecode/docker.yml
