FROM centos:7
ENV container docker

WORKDIR /root

# 设置时区
ENV TZ Asia/Shanghai
RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# 安装软件
RUN yum install -y vim wget git gcc gcc-c++ gdb make cmake kernel-devel automake autoconf rsync 

# 安装依赖库
RUN yum install -y cyrus-sasl-devel libuuid-devel openldap-devel zlib-devel boost-devel

# 安装neovim
RUN git clone https://gitee.com/hsby/xdata
RUN sh xdata/installtion/nvim-lastest.install.sh v0.9.5
RUN sh xdata/installtion/node-16.20.2.install.sh
RUN sh xdata/vim/install.sh
# 注意 ~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/lua/nvim-treesitter/shell_command_selectors.lua 需要修改parser编译参数

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
RUN yum update -y && yum install -y openssh-server
RUN ssh-keygen -A && echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN systemctl enable sshd
EXPOSE 22

# 启动init进程
CMD ["/usr/sbin/init"]
