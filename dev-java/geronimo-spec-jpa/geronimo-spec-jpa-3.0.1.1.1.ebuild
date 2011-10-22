# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit java-pkg-2

DESCRIPTION="Apache's Geronimo implementation of J2EE specification (JPA)"
HOMEPAGE="http://geronimo.apache.org"
SRC_URI="${P}.tar.bz2"
# svn export https://svn.apache.org/repos/asf/geronimo/specs/tags/geronimo-jpa_3.0_spec-1.1.1 geronimo-spec-jpa-3.0.1.1.1
# tar jcf geronimo-spec-jpa-3.0.1.1.1.tar.bz2 geronimo-spec-jpa-3.0.1.1.1

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="source"
DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

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
