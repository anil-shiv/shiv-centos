FROM centos:centos8

WORKDIR /opt
RUN cd /etc/yum.repos.d/ && sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
        sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
        yum update -y
RUN yum clean all && \
yum update -y && \
yum install -y dstat \
                openssh-server openssh-clients \
                lsof \
                mailx \
                mtr \
                nc \
                rsync \
                strace \
                traceroute \
                unzip \
                svn \
                git \
                sudo \
                perl-LDAP \
                wget \
                passwd \
                yum-utils \
                zip && \
    mkdir /dist && \
    ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime 

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

RUN unzip awscliv2.zip
RUN ./aws/install

RUN yum install epel-release -y
RUN yum install python3.9 -y 
RUN python3.9 -V
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.9 get-pip.py --user &&\
    python3.9 -m pip install --user ansible

COPY target/makefile-common /opt/makefile-common/

RUN yum install make -y