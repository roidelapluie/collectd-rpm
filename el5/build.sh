#!/bin/bash

# Install tools required to build the rpms
yum install -y rpm-build yum-utils rpmdevtools

# Install EPEL
rpm -ivh http://mir01.syntis.net/epel/5/i386/epel-release-5-4.noarch.rpm

# Go to /tmp to get and extract collectd source base
cd /tmp
wget -c http://collectd.org/files/collectd-5.4.2.tar.bz2

# Extract source
tar xvf collectd-5.4.2.tar.bz2

# Copy sources in build directory
cp collectd-5.4.2.tar.bz2 /usr/src/redhat/SOURCES/

# Fix the specfile to match collected version
sed -i s/5.4.0/5.4.2/ collectd-5.4.2/contrib/redhat/collectd.spec

# Install dependencies of the spec file
yum install -y $(egrep "^BuildRequires" collectd-5.4.2/contrib/redhat/collectd.spec | cut -d ':' -f 2 | tr -d ' \t' | sed 's/,/\n/' | uniq | sed 's/$/ /' | tr -d '\n' | tr ',' ' ')

# Create RPMS
rpmbuild -bb collectd-5.4.2/contrib/redhat/collectd.spec

# Copy RPMs back to the host
cp -rv /usr/src/redhat/RPMS/ /vagrant

