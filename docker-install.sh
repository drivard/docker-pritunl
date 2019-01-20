set -ex

apt-get update -q
apt-get install -y locales iptables wget gnupg2

if [ "${MONGODB_VERSION}" != "no" ]; then
    echo 'deb https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse' > /etc/apt/sources.list.d/mongodb-org-4.0.list
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
fi

echo 'deb https://repo.pritunl.com/stable/apt bionic main' > /etc/apt/sources.list.d/pritunl.list
#echo "deb http://build.openvpn.net/debian/openvpn/stable bionic main" > /etc/apt/sources.list.d/openvpn-aptrepo.list

apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
#apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 8E6DA8B4E158C569

locale-gen en_US en_US.UTF-8
dpkg-reconfigure locales
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
apt-get upgrade -y -q
apt-get dist-upgrade -y -q

# install pritunl
apt-get update -q
apt-get install -y -q pritunl

if [ "${MONGODB_VERSION}" != "no" ]; then
    apt-get -y install mongodb-org=${MONGODB_VERSION};
fi

apt-get --purge autoremove -y wget
apt-get clean
apt-get -y -q autoclean
apt-get -y -q autoremove
rm -rf /tmp/*
