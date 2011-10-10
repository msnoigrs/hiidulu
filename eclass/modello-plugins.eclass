# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @eclass-begin
# @ECLASS: java-modello-utils.eclass
# @MAINTAINER:
# IGARASHI Masanao <igarashi@gentoo.gr.jp>
#
# Original Author: IGARASHI Masanao <igarashi@gentoo.gr.jp>
#
# @BLURB: Eclass for building dev-java/modello-plugin-* packages
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# dev-java/modello-plugins-* packages easily.

JAVA_PKG_IUSE="doc source"

inherit versionator java-modello-utils java-pkg-2 java-ant-2

#EXPORT_FUNCTIONS src_unpack src_compile src_install

# TODO: unknown source for now
FROMSVN="yes"

if [ -z "${FROMSVN}" -o "${FROMSVN}" != "yes" ]; then
# @ECLASS-VARIABLE: FROMSVN
# @DESCRIPTION:
# If set to 'yes', treat as live ebuild.
	FROMSVN="no"
else
	inherit subversion
	FROMSVN="yes"
fi

EXPORT_FUNCTIONS src_unpack src_install

# -----------------------------------------------------------------------------
# @variable-preinherit MODELLO_PLUGIN_JDKVER
# @variable-default 1.5
#
# Affects the >=virtual/jdk version set in DEPEND string. Defaults to 1.5, can
# be overriden from ebuild BEFORE inheriting this eclass.
# -----------------------------------------------------------------------------
MODELLO_PLUGIN_JDKVER=${MODELLO_PLUGIN_JDKVER-1.5}

# -----------------------------------------------------------------------------
# @variable-preinherit MODELLO_PLUGIN_JREVER
# @variable-default 1.5
#
# Affects the >=virtual/jre version set in DEPEND string. Defaults to 1.5, can
# be overriden from ebuild BEFORE inheriting this eclass.
# -----------------------------------------------------------------------------
MODELLO_PLUGIN_JREVER=${MODELLO_PLUGIN_JREVER-1.5}

# -----------------------------------------------------------------------------
# @variable-internal MODELLO_PLUGIN_NAME
# @variable-default the rest of $PN after "modello-plugin-"
#
# The name of this modello plugin
# derived from $PN.
# -----------------------------------------------------------------------------
MODELLO_PLUGIN_NAME="${PN#modello-plugin-}"

# -----------------------------------------------------------------------------
# @variable-preinherit MODELLO_PLUGIN_DEPNAME
# @variable-default $MODELLO_PLUGIN_NAME
#
# Specifies JAVA_PKG_NAME (PN{-SLOT} used with java-pkg_jar-from) of the package
# that this one depends on. Defaults to the name of modello plugin, ebuild can
# override it before inheriting this eclass.
# -----------------------------------------------------------------------------
#MODELLO_PLUGIN_DEPNAME=${MODELLO_PLUGIN_DEPNAME-${MODELLO_PLUGIN_NAME}}


# -----------------------------------------------------------------------------
# @variable-internal MODELLO_PLUGIN_PV
# @variable-default Just the number in $PV without any beta/RC suffixes
#
# Version of modello-core this plugin is intended to register and thus load with.
# -----------------------------------------------------------------------------
MODELLO_PLUGIN_PV="${PV}"

if [ ${PV} = "9999" ]; then
	MY_PV="1.0.2"
else
	MY_PV="${PV}"
fi

# special care for beta/RC releases
#if [[ ${PV} == *beta2* ]]; then
#	MY_PV=${PV/_beta2/beta}
#	MODELLO_PLUGIN_PV=$(get_version_component_range 1-3)
#elif [[ ${PV} == *_rc* ]]; then
#	MY_PV=${PV/_rc/RC}
#	MODELLO_PLUGIN_PV=$(get_version_component_range 1-3)
#else
#	# default for final releases
#	MY_PV=${PV}
#fi

# -----------------------------------------------------------------------------
# Default values for standard ebuild variables, can be overriden from ebuild.
# -----------------------------------------------------------------------------
#DESCRIPTION="Modello plugin ${MODELLO_PLUGIN_DEPNAME}"
DESCRIPTION="Modello plugin ${MODELLO_PLUGIN_NAME}"
HOMEPAGE="http://modello.codehaus.org/"
if [ "${FROMSVN}" = "yes" ]; then
	if [ ${PV} = "9999" ]; then
		ESVN_REPO_URI="http://svn.codehaus.org/modello/trunk/modello-plugins/${PN}"
	else
		ESVN_REPO_URI="http://svn.codehaus.org/modello/tags/modello-${MY_PV}/modello-plugins/${PN}"
	fi
	SRC_URI=""
else
	SRC_URI="" # TODO unknown
fi
LICENSE="as-is"
SLOT="0"
IUSE=""

RDEPEND=">=virtual/jre-${MODELLO_PLUGIN_JREVER}
	~dev-java/modello-core-${PV}
	dev-java/plexus-container-default:1.1"
#	dev-java/plexus-component-api"
DEPEND=">=virtual/jdk-${MODELLO_PLUGIN_JDKVER}
	${RDEPEND}"

# Would run the full ant test suite for every modello plugin
RESTRICT="test"

#S="${WORKDIR}/${MY_P}"

# ------------------------------------------------------------------------------
# @eclass-src_unpack
#
# performs the unpack, build.xml replacement and symlinks modello-core.jar from
#	modello-core
# ------------------------------------------------------------------------------
modello-plugins_src_unpack() {
	subversion_src_unpack
	cd ${S}
	cp /usr/share/modello-core/etc/gentoo-build.xml build.xml
	mkdir ${S}/lib || die "faile to create libdir"
	java-pkg_jar-from --into lib --build-only modello-core
	java-pkg_jar-from --into lib --build-only plexus-container-default-1.1
	#java-pkg_jar-from --into lib --build-only plexus-component-api
}

# ------------------------------------------------------------------------------
# @eclass-src_compile
#
# Compiles the jar with installed modello-core.
# ------------------------------------------------------------------------------
#modello-plugins_src_compile() {
#	java-pkg-2_src_compile
#}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

# ------------------------------------------------------------------------------
# @eclass-src_install
#
# Installs the jar and registers its presence for the ant launcher script.
# Version param ensures it won't get loaded (thus break) when ant-core is
# updated to newer version.
# ------------------------------------------------------------------------------
modello-plugins_src_install() {
	java-pkg_dojar target/${PN}.jar
#	java-modello_register-modello-plugin --version "${MODELLO_PLUGIN_PV}"
	java-modello_register-modello-plugin

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}

# ------------------------------------------------------------------------------
# @eclass-end
# ------------------------------------------------------------------------------
