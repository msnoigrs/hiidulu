# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2

JAXEN_V="1.1.6"
JAXEN_P="jaxen-${JAXEN_V}"

DESCRIPTION="XOM is a new XML object model. It is a tree-based API for processing XML with Java that strives for correctness and simplicity."
HOMEPAGE="http://www.xom.nu/"
SRC_URI="http://www.cafeconleche.org/XOM/${PN}-${PV}-src.tar.gz
	http://dist.codehaus.org/jaxen/distributions/${JAXEN_P}-src.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

CDEPEND="dev-java/xerces:2"
RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.5
	dev-java/jarjar:1
	${CDEPEND}
	doc? ( dev-java/tagsoup )"
#	servlet? ( java-virtuals/servlet-api:3.0 )

S="${WORKDIR}/XOM"

java_prepare() {
	mkdir "${S}/build"
	mv "${WORKDIR}/${JAXEN_P}" "${S}/build"

	epatch "${FILESDIR}/${P}-gentoo.patch"

	# remove dependency junit
	rm -rv ${S}/src/nu/xom/tests
	rm -rv ${S}/src/nu/xom/samples/inner

	cd ${S}/lib
	rm -v *.jar
	java-pkg_jar-from --build-only jarjar-1 jarjar-nodep.jar jarjar.jar
	java-pkg_jar-from xerces-2
}

src_compile() {
	local antflags="jar -Ddebug=off"
	if use doc; then
		antflags="${antflags} betterdoc -Dtagsoup.jar=$(java-pkg_getjar --build-only tagsoup tagsoup.jar)"
	fi
	eant ${antflags} || die "Failed Compiling"
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar
	dodoc Todo.txt

	use doc && java-pkg_dohtml -r apidocs/
	use source && java-pkg_dosrc src/*
	use examples && java-pkg_doexamples --subdir nu/xom/samples src/nu/xom/samples
}
