# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="source"

#ESVN_REPO_URI="http://svn.codehaus.org/jruby/jcodings/trunk"
#inherit subversion java-pkg-2 java-ant-2

EGIT_REPO_URI="git://github.com/jruby/jcodings.git"
inherit git-2 java-pkg-2 java-ant-2

DESCRIPTION="Byte-based encoding support library for Java"
HOMEPAGE="http://jruby.codehaus.org/"
# svn export http://svn.codehaus.org/jruby/jcodings/tags/1.0.2 jcodings-1.0.2
# tar jcf jcodings-1.0.2.tar.bz2 jcodings-1.0.2
#SRC_URI=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

EANT_BUILD_TARGET="build"

src_install() {
	java-pkg_newjar target/${PN}.jar
	use source && java-pkg_dosrc src/*
}
