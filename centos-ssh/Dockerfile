FROM centos:7
ENV container docker

# 设置时区
ENV TZ Asia/Shanghai
RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# 安装vim
RUN yum install -y vim
ADD .vimrc /root/.vimrc

# 安装 openssh-server
RUN yum update -y && yum install -y openssh-server

# 配置 SSHD
RUN ssh-keygen -A && echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

# 安装 systemd
RUN yum install -y systemd; yum clean all; \
  (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -vf $i; done); \
  rm -vf /lib/systemd/system/multi-user.target.wants/*; \
  rm -vf /etc/systemd/system/*.wants/*; \
  rm -vf /lib/systemd/system/local-fs.target.wants/*; \
  rm -vf /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -vf /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -vf /lib/systemd/system/basic.target.wants/*; \
  rm -vf /lib/systemd/system/anaconda.target.wants/*

# 配置 SSHD 服务为启动项
RUN systemctl enable sshd

# 暴露 SSH 服务端口
EXPOSE 22

# 启动init进程
CMD ["/usr/sbin/init"]
