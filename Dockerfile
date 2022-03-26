FROM centos:6

RUN sed -i -e "s/^mirrorlist=http:\/\/mirrorlist.centos.org/#mirrorlist=http:\/\/mirrorlist.centos.org/g" /etc/yum.repos.d/CentOS-Base.repo \
&& sed -i -e "s/^#baseurl=http:\/\/mirror.centos.org/baseurl=http:\/\/vault.centos.org/g" /etc/yum.repos.d/CentOS-Base.repo \
&& yum update -y && yum install -y openssh-server

RUN /usr/bin/ssh-keygen -q -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N '' >&/dev/null \
&& /usr/bin/ssh-keygen -q -t dsa -f /etc/ssh/ssh_host_dsa_key -C '' -N '' >&/dev/null \
&& chmod 600 /etc/ssh/ssh_host_*_key \
&& chmod 644 /etc/ssh/ssh_host_*_key.pub \
&& /sbin/restorecon /etc/ssh/ssh_host_rsa_key.pub
