FROM opensuse:tumbleweed
MAINTAINER Alexander Moriarty <alexander.moriarty@tba.group>

RUN zypper --non-interactive update && \
    zypper --non-interactive install \
      gcc-c++ \
      boost-devel \
      libboost_filesystem1_66_0-devel \
      libboost_system1_66_0-devel \
      libboost_program_options1_66_0-devel \
      libboost_iostreams1_66_0-devel \
      log4cpp-devel \
      unixODBC-devel \
      java-1_8_0-openjdk-devel \
      cmake \
      git \
      vim

RUN zypper --non-interactive \
      addrepo https://download.opensuse.org/repositories/devel:/libraries:/ACE:/micro/openSUSE_Tumbleweed/devel:libraries:ACE:micro.repo && \
    zypper --non-interactive --gpg-auto-import-keys refresh && \
    zypper --non-interactive install \
      ace-devel \
      tao-devel && \
    zypper clean --all

##
# WARNING: here we use some packages from openSUSE_Factory...
# https://en.opensuse.org/Portal:Factory
#  >> The Factory project is the rolling development codebase for openSUSE Tumbleweed.
#  >> Factory is mainly used as an internal term for openSUSE's distribution developers, and the target project for all contributions to openSUSE's main codebase. 
##

RUN zypper --non-interactive \
      addrepo https://download.opensuse.org/repositories/devel:libraries:c_c++/openSUSE_Factory/devel:libraries:c_c++.repo && \
    zypper --non-interactive --gpg-auto-import-keys refresh && \
    zypper --non-interactive install \
      rapidjson-devel \
      activemq-cpp-devel

RUN zypper --non-interactive \
      addrepo http://download.opensuse.org/repositories/devel:/tools:/building/openSUSE_Factory/devel:tools:building.repo && \
    zypper --non-interactive --gpg-auto-import-keys refresh && \
    zypper --non-interactive install \
      which \
      maven

RUN mkdir /local && \
    chmod g+w /local && \
    git clone https://github.com/moriarty/avro.git && \
    cd avro/lang/c++ && \
    git checkout tba && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/local/avro-67bec06-p1 .. && \
    make && \
    make install && \
    cd ../../java && \
    mvn package -DskipTests -Dhadoop.version=1 && \
    cp ./tools/target/avro-tools-1.9.0-SNAPSHOT.jar /local/avro-67bec06-p1/lib/avro-tools.jar
