# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="git://github.com/pgjdbc/pgjdbc.git"

JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION="JDBC Driver for PostgreSQL"
SRC_URI=""
HOMEPAGE="http://jdbc.postgresql.org/"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

DEPEND="
	>=virtual/jdk-1.6
	doc? (
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
	)
	test? (
		dev-java/ant-junit
		dev-db/postgresql-server
	)"
RDEPEND=">=virtual/jre-1.6"

S="${WORKDIR}/pgjdbc"

RESTRICT="test"

java_prepare() {
	java-ant_rewrite-classpath
}

src_compile() {
	eant jar $(use_doc publicapi)

	# There is a task that creates this doc but I didn't find a way how to use system catalog
	# to lookup the stylesheet so the 'doc' target is rewritten here to use system call instead.
	if use doc; then
		mkdir -p "${S}/build/doc"
		xsltproc -o "${S}/build/doc/pgjdbc.html" http://docbook.sourceforge.net/release/xsl/current/xhtml/docbook.xsl \
			"${S}/doc/pgjdbc.xml"
	fi
}

src_test() {
	einfo "In order to run the tests successfully, you have to have:"
	einfo "1) PostgreSQL server running"
	einfo "2) database 'test' defined with user 'test' with password 'password'"
	einfo "   as owner of the database"
	einfo "3) plpgsql support in the 'test' database"
	einfo
	einfo "You can find a general info on how to perform these steps at"
	einfo "http://gentoo-wiki.com/HOWTO_Configure_Postgresql"

	ANT_TASKS="ant-junit" eant test -Dgentoo.classpath=$(java-pkg_getjars --build-only junit)
}

src_install() {
	java-pkg_newjar jars/postgresql*.jar jdbc-postgresql.jar

	if use doc ; then
		java-pkg_dojavadoc build/publicapi
		dohtml build/doc/pgjdbc.html
	fi

	use source && java-pkg_dosrc org
}
