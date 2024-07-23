FROM --platform=linux/amd64 centos:7
ENV container docker

# 初始化系统&安装neovim
WORKDIR /root
RUN git clone https://gitee.com/hsby/xdata &&\
    sh init_centos7.sh &&\
    sh xdata/installtion/nvim-lastest.install.sh v0.9.5 &&\
    sh xdata/installtion/node-16.20.2.install.sh &&\
    sh xdata/installtion/bear-2.4.4.install.sh &&\
    sh xdata/vim/install.sh

# 安装systemd
RUN yum install -y systemd; yum clean all; \
  (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -vf $i; done); \
  rm -vf /lib/systemd/system/multi-user.target.wants/*; \
  rm -vf /etc/systemd/system/*.wants/*; \
  rm -vf /lib/systemd/system/local-fs.target.wants/*; \
  rm -vf /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -vf /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -vf /lib/systemd/system/basic.target.wants/*; \
  rm -vf /lib/systemd/system/anaconda.target.wants/*

# 安装openssh-server
RUN yum update -y &&\
    yum install -y openssh-server &&\
    ssh-keygen -A &&\
    echo 'root:123456' | chpasswd &&\
    sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config &&\
    systemctl enable sshd
EXPOSE 22

WORKDIR /root

# 启动init进程
CMD ["/usr/sbin/init"]
