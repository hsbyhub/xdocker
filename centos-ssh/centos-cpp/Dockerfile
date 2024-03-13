FROM centos-ssh
ENV container docker

RUN yum install -y gcc gcc-c++ kernel-devel gdb make automake autoconf rsync
RUN yum install -y wget
ADD cmake-3.11.0-Linux-x86_64 /usr/local/cmake-3.11.0
RUN echo '' >> /root/.bashrc
RUN echo 'PATH=$PATH:/usr/local/cmake-3.11.0/bin' >> /root/.bashrc
