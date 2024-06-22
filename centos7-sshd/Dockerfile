FROM --platform=linux/amd64 centos:7
ENV container docker

# 设置时区
ENV TZ Asia/Shanghai
RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone
# 安装中文
RUN yum install kde-l10n-Chinese -y
RUN yum install glibc-common -y
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
RUN export LANG=zh_CN.UTF-8
RUN echo "export LANG=zh_CN.UTF-8" >> /etc/locale.conf
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8


# 安装软件和依赖库
RUN yum install -y epel-release &&\
    yum install -y vim wget git gcc gcc-c++ gdb make cmake kernel-devel automake autoconf rsync binutils patchelf zip unzip &&\
    yum install -y cyrus-sasl-devel libuuid-devel openldap-devel zlib-devel boost-devel

# 安装neovim
WORKDIR /root
RUN git clone https://gitee.com/hsby/xdata &&\
    sh xdata/installtion/nvim-lastest.install.sh v0.9.5 &&\
    sh xdata/installtion/node-16.20.2.install.sh &&\
    sh xdata/installtion/bear-2.4.4.install.sh &&\
    sh xdata/vim/install.sh &&\
    yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo &&\
    yum install -y ripgrep
# 注意 ~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/lua/nvim-treesitter/shell_command_selectors.lua 需要修改compile参数

# 安装glibc
WORKDIR /usr/local/src
RUN wget https://mirrors.tuna.tsinghua.edu.cn/gnu/glibc/glibc-2.18.tar.gz &&\
    tar zxvf glibc-2.18.tar.gz &&\
    mkdir -p glibc-2.18/build
WORKDIR glibc-2.18/build
RUN ../configure --prefix=/usr/local/glibc-2.18 &&\
    make -j8 &&\
    make install

# 安装clangd && 兼容GLIBC_2.18
WORKDIR /usr/local/src
RUN wget https://github.com/clangd/clangd/releases/download/18.1.3/clangd-linux-18.1.3.zip &&\
    unzip clangd-linux-18.1.3.zip -d /usr/local/ &&\
    echo '#! /usr/bin/env bash' >> /usr/local/bin/clangd &&\
    echo '/usr/local/glibc-2.18/lib/ld-2.18.so /usr/local/clangd_18.1.3/bin/clangd' >> /usr/local/bin/clangd &&\
    chmod 755 /usr/local/bin/clangd

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
