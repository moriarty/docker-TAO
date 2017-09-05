FROM opensuse/tumbleweed
#FROM ubuntu
#MAINTAINER Yong Fu <larry.yong.fu@hotmail.com>

RUN zypper --non-interactive refresh
RUN zypper --non-interactive install wget vim
RUN zypper --non-interactive install --type pattern devel_basis
RUN zypper --non-interactive install gcc-c++

# ACE + TAO
# RUN wget  http://download.dre.vanderbilt.edu/previous_versions/ACE+TAO-6.2.0.tar.gz
RUN wget https://github.com/DOCGroup/ACE_TAO/archive/ACE+TAO-6_4_4.tar.gz
RUN mkdir /local
RUN tar -xvf ACE+TAO-6_4_4.tar.gz -C /local
ENV ACE_ROOT /local/ACE_TAO-ACE-TAO-6_4_4/ACE
ENV TAO_ROOT /local/ACE_TAO-ACE-TAO-6_4_4/TAO
ENV PATH $PATH:$ACE_ROOT/bin

RUN wget https://github.com/DOCGroup/MPC/archive/ACE+TAO-6_4_4.tar.gz
RUN tar -xvf ACE+TAO-6_4_4.tar.gz.1 -C /local
ENV MPC_ROOT=/local/MPC-ACE-TAO-6_4_4

RUN rm -f ACE+TAO-6_4_4.tar.gz
RUN rm -f ACE+TAO-6_4_4.tar.gz.1

# there is a bug in Docker so we cannot use (https://github.com/dotcloud/docker/issues/2637)
# ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$ACE_ROOT/lib
# instead
ENV LD_LIBRARY_PATH $ACE_ROOT/lib

ADD config.h $ACE_ROOT/ace/config.h
ADD platform_macros.GNU $ACE_ROOT/include/makeinclude/platform_macros.GNU

# build ACE first
#RUN $ACE_ROOT/bin/mwc.pl -type gnuace TAO_ACE.mwc
#RUN cd $ACE_ROOT/ace;make
#build gperf
#RUN cd $ACE_ROOT/apps/gperf/src;make
#RUN cd $TAO_ROOT;make
#RUN rm -f ACE+TAO-6_4_4.tar.gz
