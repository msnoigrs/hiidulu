# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="source test"

EGIT_REPO_URI="git://github.com/jruby/bytelist.git"

inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION="JRuby support library"
HOMEPAGE="http://jruby.codehaus.org/"
LICENSE="|| ( CPL-1.0 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=">=virtual/jre-1.5
	dev-java/jcodings"

DEPEND=">=virtual/jdk-1.5
	dev-java/jcodings
	test? ( dev-java/ant-junit )"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="jcodings"

java_prepare() {
	# Don't do tests unnecessarily.
	sed -i 's:depends="test":depends="compile":' build.xml
	# Bug 325189
	mkdir -p lib
}

src_install() {
	java-pkg_newjar lib/${PN}-1.0.2.jar
	use source && java-pkg_dosrc src/*
}

src_test() {
	ANT_TASKS="ant-junit" eant test
}
