# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Lots of small utilities for bndlib, a swiss army knife for OSGi"
HOMEPAGE="http://www.aqute.biz/Bnd/Bnd"
SRC_URI="https://github.com/bndtools/bnd/archive/${PV}.REL.tar.gz -> bndlib-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEP="dev-java/bndlib"
DEPEND=">=virtual/jdk-1.6
	dev-java/ant-core
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

MY_BNDBASE="${WORKDIR}/bnd-${PV}.REL/biz.aQute.bnd"
S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	mkdir -p "${S}/src/main/java/aQute/bnd/ant"
	cp "${MY_BNDBASE}/src/aQute/bnd/ant/"* "${S}/src/main/java/aQute/bnd/ant"
	#cp "${MY_BNDBASE}/src/aQute/bnd/ant/taskdef.properties" "${S}/src/main/java/aQute/bnd/ant"
	#cp "${MY_BNDBASE}/src/aQute/bnd/ant/AntMessages.java" "${S}/src/main/java/aQute/bnd/ant"
	#cp "${MY_BNDBASE}/src/aQute/bnd/ant/BaseTask.java" "${S}/src/main/java/aQute/bnd/ant"
	#cp "${MY_BNDBASE}/src/aQute/bnd/ant/BndTask.java" "${S}/src/main/java/aQute/bnd/ant"
	#cp "${MY_BNDBASE}/src/aQute/bnd/ant/ProjectBuildOrderTask.java" "${S}/src/main/java/aQute/bnd/ant"
	#cp "${MY_BNDBASE}/src/aQute/bnd/ant/EclipseTask.java" "${S}/src/main/java/aQute/bnd/ant"
}

java_prepare() {
	cp ${FILESDIR}/gentoo-build.xml build.xml

	mkdir lib || die
	java-pkg_jar-from --into lib bndlib
	java-pkg_jar-from --into lib --build-only ant-core ant.jar
}

JAVA_ANT_ENCODING="utf-8"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar
	java-pkg_register-ant-task
}
