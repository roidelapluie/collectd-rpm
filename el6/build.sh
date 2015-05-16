#!/bin/bash

# Install tools required to build the rpms
yum install -y rpm-build yum-utils rpmdevtools

# Install EPEL
rpm -ivh http://mir01.syntis.net/epel/6/i386/epel-release-6-8.noarch.rpm

# Go to /tmp to get and extract collectd source base
cd /tmp
wget -c http://collectd.org/files/collectd-5.4.2.tar.bz2

# Extract source
tar xvf collectd-5.4.2.tar.bz2

# Create build directory
mkdir -p /root/rpmbuild/SOURCES/

# Copy sources in build directory
cp collectd-5.4.2.tar.bz2 /root/rpmbuild/SOURCES/

# Fix the specfile to match collected version
sed -i s/5.4.0/5.4.2/ collectd-5.4.2/contrib/redhat/collectd.spec

# Install dependencies of the spec file
yum-builddep -y collectd-5.4.2/contrib/redhat/collectd.spec

# Create RPMS
rpmbuild -bb collectd-5.4.2/contrib/redhat/collectd.spec

# Copy RPMs back to the host
cp -rv /root/rpmbuild/RPMS/ /vagrant

