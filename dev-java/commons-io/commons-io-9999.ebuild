# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc source"
ESVN_REPO_URI="https://svn.apache.org/repos/asf/commons/proper/io/trunk"

inherit subversion java-pkg-2 java-ant-2

MY_P="${P}-src"
DESCRIPTION="Commons-IO contains utility classes, stream implementations, file filters, and endian classes."
HOMEPAGE="http://commons.apache.org/io/"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="test"

DEPEND=">=virtual/jdk-1.6
	test? ( dev-java/ant-junit )"
RDEPEND=">=virtual/jre-1.6"

java_prepare() {
	java-ant_ignore-system-classes
	java-ant_rewrite-classpath
	# Setting java.io.tmpdir doesn't have effect unless we do this because the
	# vm is forked
	java-ant_xml-rewrite -f build.xml --change -e junit -a clonevm -v "true"
}

EANT_EXTRA_ARGS="-Duser.home=${T}"

src_test() {
	if has userpriv ${FEATURES}; then
		ANT_OPTS="-Djava.io.tmpdir=${T} -Duser.home=${T}" \
		ANT_TASKS="ant-junit" \
			eant test \
			-Dgentoo.classpath="$(java-pkg_getjars junit)" \
			-Dlibdir="libdir" \
			-Djava.io.tmpdir="${T}"
	else
		elog "Tests fail unless userpriv is enabled because they test for"
		elog "file permissions which doesn't work when run as root."
	fi
}

src_install() {
	java-pkg_newjar target/${PN}-2.2-SNAPSHOT.jar ${PN}.jar

	dodoc RELEASE-NOTES.txt NOTICE.txt || die
	use doc && java-pkg_dojavadoc target/apidocs
	use source && java-pkg_dosrc src/java/*
}
