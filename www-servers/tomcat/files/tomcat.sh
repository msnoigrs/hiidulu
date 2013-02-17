#!/bin/bash

PIDFILE="/run/tomcat-7.pid"

CATALINA_HOME="/usr/share/tomcat-7"
CATALINA_BASE="/var/lib/tomcat-7"
CATALINA_TMPDIR="/var/tmp/tomcat-7"
CATALINA_USER="tomcat"
CATALINA_GROUP="tomcat"

#CATALINA_OPTS="-Djava.security.manager -Djava.security.policy=${CATALINA_HOME}/conf/catalina.policy"
#JAVA_OPTS="-Djava.net.preferIPv4Stack=true"

if [ -f /etc/conf.d/tomcat-7 ]; then
	source /etc/conf.d/tomcat-7
fi

export JAVA_HOME=$(java-config ${TOMCAT_JVM:+--select-vm ${TOMCAT_JVM}} --jre-home)

CLASSPATH=$(java-config --classpath tomcat-7${TOMCAT_EXTRA_JARS:+,${TOMCAT_EXTRA_JARS}})
export CLASSPATH="${CLASSPATH}${TOMCAT_EXTRA_CLASSPATH:+:${TOMCAT_EXTRA_CLASSPATH}}"

# resolve links - $0 may be a softlink
ARG0="${0}"
while [ -h "${ARG0}" ]; do
	ls=$(ls -ld "${ARG0}")
	link=$(expr "${ls}" : '.*-> \(.*\)$')
	if expr "${link}" : '/.*' > /dev/null; then
		ARG0="${link}"
	else
		ARG0="$(dirname ${ARG0})/${link}"
	fi
done
DIRNAME="$(dirname ${ARG0})"
PROGRAM="$(basename ${ARG0})"

while [ ".${1}" != "." ]
do
	case "${1}" in
		--java-home )
			JAVA_HOME="${2}"
			shift; shift;
			continue
			;;
		--catalina-home )
			CATALINA_HOME="${2}"
			shift; shift;
			continue
			;;
		--catalina-base )
			CATALINA_BASE="${2}"
			shift; shift;
			continue
			;;
		--catalina-pid )
			PIDFILE="${2}"
			shift; shift;
			continue
			;;
		--tomcat-user )
			CATALINA_USER="${2}"
			shift; shift;
			continue
			;;
		* )
			break
			;;
	esac
done

# Use the maximum available, or set MAX_FD != -1 to use that
[ ".${MAX_FD}" = "." ] && MAX_FD="maximum"
# Setup parameters for running the jsvc
#

# Only set CATALINA_HOME if not already set
[ ".${CATALINA_BASE}" = "." ] && CATALINA_BASE="${CATALINA_HOME}"
[ ".${CATALINA_MAIN}" = "." ] && CATALINA_MAIN="org.apache.catalina.startup.Bootstrap"
[ ".${JSVC}" = "." ] && JSVC="/usr/bin/jsvc"

# Ensure that any user defined CLASSPATH variables are not used on startup,
# but allow them to be specified in setenv.sh, in rare case when it is needed.
JAVA_OPTS=

COMMONS_DAEMON=$(java-config --classpath commons-daemon)

# Add on extra jar files to CLASSPATH
CLASSPATH="${CLASSPATH}:${COMMONS_DAEMON}"

[ ".${CATALINA_OUT}" = "." ] && CATALINA_OUT="${CATALINA_BASE}/logs/catalina-daemon.out"
[ ".${CATALINA_ERR}" = "." ] && CATALINA_ERR="${CATALINA_BASE}/logs/catalina-daemon.err"
[ ".${CATALINA_TMPDIR}" = "." ] && CATALINA_TMPDIR="${CATALINA_BASE}/temp"

if [ -z "${LOGGING_CONFIG}" ]; then
	if [ -r "${CATALINA_BASE}/conf/logging.properties" ]; then
		LOGGING_CONFIG="-Djava.util.logging.config.file=${CATALINA_BASE}/conf/logging.properties"
	else
    	# Bugzilla 45585
		LOGGING_CONFIG="-Dnop"
	fi
fi

[ ".${LOGGING_MANAGER}" = "." ] && LOGGING_MANAGER="-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager"
JAVA_OPTS="${JAVA_OPTS} ${LOGGING_MANAGER}"

# Set -pidfile
[ ".${PIDFILE}" = "." ] && PIDFILE="${CATALINA_BASE}/logs/catalina-daemon.pid"

#			-Djava.endorsed.dirs="$JAVA_ENDORSED_DIRS" \
case "${1}" in
	run )
		shift
		"${JSVC}" ${*} \
			${JSVC_OPTS} \
			-java-home "${JAVA_HOME}" \
			-pidfile "${PIDFILE}" \
			-wait 10 \
			-nodetach \
			-outfile "${CATALINA_OUT}" \
			-errfile '&1' \
			-classpath "${CLASSPATH}" \
			"${LOGGING_CONFIG}" ${JAVA_OPTS} ${CATALINA_OPTS} \
			-Dcatalina.base="${CATALINA_BASE}" \
			-Dcatalina.home="${CATALINA_HOME}" \
			-Djava.io.tmpdir="${CATALINA_TMPDIR}" \
			${CATALINA_MAIN}
		exit $?
		;;
    start )
		"${JSVC}" ${JSVC_OPTS} \
			-java-home "${JAVA_HOME}" \
			-user ${CATALINA_USER} \
			-pidfile "${PIDFILE}" \
			-wait 10 \
			-outfile "${CATALINA_OUT}" \
			-errfile "${CATALINA_ERR}" \
			-classpath "${CLASSPATH}" \
			"${LOGGING_CONFIG}" ${JAVA_OPTS} ${CATALINA_OPTS} \
			-Dcatalina.base="${CATALINA_BASE}" \
			-Dcatalina.home="${CATALINA_HOME}" \
			-Djava.io.tmpdir="${CATALINA_TMPDIR}" \
			${CATALINA_MAIN}
		exit $?
		;;
    stop )
		"${JSVC}" ${JSVC_OPTS} \
			-stop \
			-pidfile "${PIDFILE}" \
			-classpath "${CLASSPATH}" \
			-Djava.endorsed.dirs="${JAVA_ENDORSED_DIRS}" \
			-Dcatalina.base="${CATALINA_BASE}" \
			-Dcatalina.home="${CATALINA_HOME}" \
			-Djava.io.tmpdir="${CATALINA_TMPDIR}" \
			${CATALINA_MAIN}
		exit $?
		;;
    version )
		"${JSVC}" \
			-java-home "${JAVA_HOME}" \
			-pidfile "${PIDFILE}" \
			-classpath "${CLASSPATH}" \
			-errfile "${CATALINA_ERR}" \
			-version \
			-check \
			${CATALINA_MAIN}
			if [ "$?" = 0 ]; then
				$(java-config -J) \
					-classpath "${CATALINA_HOME}/lib/catalina.jar" \
					org.apache.catalina.util.ServerInfo
			fi
			exit $?
			;;
    * )
		echo "Unknown command: \`$1'"
		echo "Usage: $PROGRAM ( commands ... )"
		echo "commands:"
		echo "  run               Start Tomcat without detaching from console"
		echo "  start             Start Tomcat"
		echo "  stop              Stop Tomcat"
		echo "  version           What version of commons daemon and Tomcat"
		echo "                    are you running?"
		exit 1
		;;
esac
