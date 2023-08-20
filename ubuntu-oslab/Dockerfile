FROM ubuntu:20.04
 
# 安装oslab环境
COPY env /root/env
RUN \
apt-get update \
&& cd /root/env \
&& tar -xvf gcc-3.4.tar.gz \
&& tar -xvf hit-oslab-linux-20110823.tar.gz \
&& apt-get install -y binutils \
&& cd ./gcc-3.4/amd64 \
&& dpkg -i *.deb \
&& apt-cache search as86 ld86 \
&& apt install bin86 \
&& apt install -y libc6-dev-i386 \
&& cd ../../oslab/linux-0.11 \
&& apt-get install make \
&& make all \
&& dpkg --add-architecture i386 \
&& apt-get update \
&& apt-get install -y libsm6:i386 \
&& apt-get install -y libx11-6:i386 \
&& apt-get install -y libxpm4:i386

# 开启sshd
RUN apt update && apt install  openssh-server sudo -y
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN service ssh start
RUN echo 'root:xunzhao' | chpasswd
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
