# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="https://svn.java.net/svn/beansbinding~svn/trunk/beansbinding"
inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Implementation of JSR295."
HOMEPAGE="http://java.net/projects/beansbinding/"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
KEYWORDS=""

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

# https://bugs.gentoo.org/show_bug.cgi?id=249740
# Quite weird. Should look into why this is happening.
JAVA_PKG_FILTER_COMPILER="ecj-3.4 ecj-3.3 ecj-3.2"

#	find -name '*.jar' -exec rm -v {} \;
	# It should report for upstream
#	sed -i -e "s/@{/\${/g" nbproject/build-impl.xml

java_prepare() {
	find -depth -type d -name .svn -exec rm -rf {} \;
	java-ant_bsfix_one nbproject/build-impl.xml
}

#ANT_EXTRA_ARGS="-Ddestdir=build/classes"

src_install() {
	java-pkg_dojar "dist/${PN}.jar"
	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/*
}
