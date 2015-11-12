# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit java-pkg-2

DESCRIPTION="Apache's Geronimo implementation of J2EE specification (JMS)"
HOMEPAGE="http://geronimo.apache.org"
MY_TARBALL="geronimo-spec-jms-1.1.1.1.1.tar.bz2"
SRC_URI="http://osdn.jp/frs/chamber_redir.php?m=iij&f=%2Fusers%2F9%2F9536%2F${MY_TARBALL} -> ${MY_TARBALL}"
# svn export https://svn.apache.org/repos/asf/geronimo/specs/tags/geronimo-jms_1.1_spec-1.1.1 geronimo-spec-jms-1.1.1.1.1
# tar jcf geronimo-spec-jms-1.1.1.1.1.tar.bz2 geronimo-spec-jms-1.1.1.1.1

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="source"
DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

src_compile() {
	local classes="${S}/target/classes"

	mkdir -p ${classes} || die
	cd src/main/java
	ejavac -d ${classes} $(find -name '*.java')

	jar cf ${S}/target/${PN}.jar -C ${classes} . || die "jar fail"
}

src_install() {
	java-pkg_dojar "${S}/target/${PN}.jar"

	use source && java-pkg_dosrc src/main/java
}
