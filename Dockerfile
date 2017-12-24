FROM centos:6.6
MAINTAINER Robert Grzelka <robert.grzelka@outlook.com>
#BASED ON: https://github.com/yhpark/dockerfile-pintos-kaist
#...https://github.com/JohnStarich/docker-pintos/blob/master/Dockerfile
RUN yum install git tar -y 
#write env variables
ENV setup_dir /pintos/setup
ENV pintos_dir /pintos

#create volume that will appear at runtime mounted
VOLUME [$pintos_dir]

RUN mkdir -p $pintos_dir
RUN mkdir -p $setup_dir

RUN echo "######################### COPY GIT PINTOS TO USER #########################"

RUN git clone https://github.com/robgrzel/PintOS /tmp/$pintos_dir

RUN mv /tmp/pintos/* $pintos_dir

RUN ls -la $pintos_dir
RUN ls -la $pintos_dir/

WORKDIR $setup_dir

ADD pintos-misc $setup_dir/pintos/src/misc/
ADD pintos-utils $setup_dir/pintos-utils/

#RUN mv $pintos_dir/bochs-2.2.6.tar.gz $setup_dir/
#RUN mv $pintos_dir/qemu-0.15.0-1.el6.rfx.x86_64.rpm  $setup_dir/
#RUN mv $pintos_dir/qemu-img-0.15.0-1.el6.rfx.x86_64.rpm  $setup_dir/

RUN SRCDIR=$setup_dir DSTDIR=/usr/ PINTOSDIR=$setup_dir/pintos $setup_dir/pintos/src/misc/bochs-2.2.6-build.sh
RUN rpm -i $setup_dir/qemu-img-0.15.0-1.el6.rfx.x86_64.rpm
RUN rpm -i $setup_dir/qemu-0.15.0-1.el6.rfx.x86_64.rpm

WORKDIR $setup_dir/pintos-utils/

RUN make

WORKDIR $pintos_dir

env PATH $setup_dir/pintos-utils/:$PATH