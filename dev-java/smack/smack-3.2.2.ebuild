# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-contrib"

inherit java-pkg-2 java-ant-2

MY_P="smack_src_3_2_2"

DESCRIPTION="An Open Source XMPP (Jabber) client library for instant messaging and presence"
HOMEPAGE="http://www.igniterealtime.org/projects/smack/index.jsp"
#SRC_URI="http://www.igniterealtime.org/downloadServlet?filename=smack/${MY_P}.tar.gz"
SRC_URI="https://github.com/igniterealtime/Smack/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

COMMON_DEP="dev-java/xpp3"
#	dev-java/jzlib"

DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

S="${WORKDIR}/Smack-${PV}"

java_prepare() {
	rm -v *.jar build/merge/*.jar build/*.jar

	cd "${S}/build/merge/"
	java-pkg_jar-from xpp3
#	java-pkg_jar-from jzlib

	cp "${FILESDIR}"/build.xml-3.2.0 "${S}/build/build.xml" || die
	sed -i -e '/zipfileset/d' "${S}/build/build.xml" || die
}

JAVA_ANT_ENCODING="iso-8859-1"
EANT_BUILD_XML="build/build.xml"
EANT_EXTRA_ARGS="-Djavadoc.dest.dir=api"

src_install() {
	java-pkg_dojar target/*.jar

	use doc && {
		java-pkg_dohtml -r documentation/*
		java-pkg_dojavadoc javadoc
	}
	use source && java-pkg_dosrc source/*
}
