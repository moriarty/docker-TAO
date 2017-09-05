FROM opensuse:tumbleweed
MAINTAINER Alexander Moriarty <alexander.moriarty@tba.group>

RUN zypper --non-interactive refresh
RUN zypper --non-interactive install --type pattern devel_basis
RUN zypper --non-interactive install gcc-c++ wget vim boost-devel
RUN zypper --non-interactive install python2 python3
RUN zypper --non-interactive install java-1_8_0-openjdk-devel
RUN zypper --non-interactive ar http://download.opensuse.org/repositories/devel:/libraries:/ACE:/micro/openSUSE_Tumbleweed/devel:libraries:ACE:micro.repo
RUN zypper --non-interactive ar http://download.opensuse.org/repositories/devel:/tools:/building/openSUSE_Leap_42.3/devel:tools:building.repo
RUN zypper --non-interactive --gpg-auto-import-keys refresh
RUN zypper --non-interactive install ace-devel tao-devel
RUN zypper --non-interactive install maven git

