#!/bin/bash

yum install -y rpm-build yum-utils rpmdevtools

rpm -ivh http://mir01.syntis.net/epel/6/i386/epel-release-6-8.noarch.rpm
cd /tmp
wget -c http://collectd.org/files/collectd-5.4.1.tar.bz2
tar xvf collectd-5.4.1.tar.bz2
mkdir -p /root/rpmbuild/SOURCES/
cp collectd-5.4.1.tar.bz2 /root/rpmbuild/SOURCES/
sed -i s/5.4.0/5.4.1/ collectd-5.4.1/contrib/redhat/collectd.spec
yum-builddep -y collectd-5.4.1/contrib/redhat/collectd.spec
rpmbuild -bb collectd-5.4.1/contrib/redhat/collectd.spec
cp -rv /root/rpmbuild/RPMS/ /vagrant

