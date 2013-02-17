#!/bin/bash

CATALINA_HOME="/usr/share/tomcat-7"
CATALINA_BASE="/var/lib/tomcat-7"
CATALINA_CONFDIR="/etc/tomcat-7"
CATALINA_TMPDIR="/var/tmp/tomcat-7"

chown_tomcat() {
	chown -R tomcat:tomcat ${1}
}

mkdir -p ${CATALINA_BASE}/{logs,webapps,work}
chmod 755 ${CATALINA_BASE}/logs
chmod 755 ${CATALINA_BASE}/work

mkdir ${CATALINA_CONFDIR}
chmod 750 ${CATALINA_CONFDIR}

mkdir ${CATALINA_TMPDIR}
chmod 755 ${CATALINA_TMPDIR}

ln -s ${CATALINA_CONFDIR} ${CATALINA_BASE}/conf
ln -s ${CATALINA_TMPDIR} ${CATALINA_BASE}/temp

cp -a ${CATALINA_HOME}/webapps/ROOT ${CATALINA_BASE}/webapps
chmod 750 ${CATALINA_BASE}/webapps
chmod 750 ${CATALINA_HOME}/webapps/ROOT
chmod 750 ${CATALINA_HOME}/webapps/ROOT/WEB-INF
chmod 640 ${CATALINA_HOME}/webapps/ROOT/*
chmod 640 ${CATALINA_HOME}/webapps/ROOT/WEB-INF/*

cp -a ${CATALINA_HOME}/conf/* ${CATALINA_CONFDIR}
chmod 640 ${CATALINA_CONFDIR}/*

mkdir -p ${CATALINA_CONFDIR}/Catalina/localhost
cp ${CATALINA_HOME}/gentoo/manager.xml ${CATALINA_CONFDIR}/Catalina/localhost
cp ${CATALINA_HOME}/gentoo/host-manager.xml ${CATALINA_CONFDIR}/Catalina/localhost

cp ${CATALINA_HOME}/gentoo/server.xml ${CATALINA_CONFDIR}
cp ${CATALINA_HOME}/gentoo/tomcat-users.xml ${CATALINA_CONFDIR}

randpw=$(echo ${RANDOM}|md5sum|cut -c 1-15)
sed -i -e "s|SHUTDOWN|${randpw}|" ${CATALINA_CONFDIR}/server.xml

chown_tomcat ${CATALINA_BASE}
chown_tomcat ${CATALINA_CONFDIR}
chown_tomcat ${CATALINA_TMPDIR}

if [ -d /usr/lib64/systemd ]; then
	cp ${CATALINA_HOME}/gentoo/tomcat.service /usr/lib64/systemd/system
	cp ${CATALINA_HOME}/gentoo/tomcat.socket /usr/lib64/systemd/system
elif [ -d /usr/lib/systemd ]; then
	cp ${CATALINA_HOME}/gentoo/tomcat.service /usr/lib/systemd/system
	cp ${CATALINA_HOME}/gentoo/tomcat.socket /usr/lib/systemd/system
fi
