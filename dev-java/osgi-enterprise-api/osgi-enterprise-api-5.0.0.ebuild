# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="OSGi Enterprise Release 5 Companion Code"
SRC_URI="http://www.osgi.org/download/r5/osgi.enterprise-${PV}.jar"
HOMEPAGE="http://www.osgi.org/Main/HomePage"

LICENSE="Apache-2.0 OSGi-Specification-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="bindist fetch"

CDEPEND="dev-java/geronimo-spec-jpa:0
	dev-java/osgi-core-api:0
	java-virtuals/servlet-api:3.0"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.6"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.6
	app-arch/unzip"

JAVA_SRC_DIR="OSGI-OPT/src"

JAVA_GENTOO_CLASSPATH="geronimo-spec-jpa,osgi-core-api,servlet-api-3.0"

pkg_nofetch() {
	einfo "Please download osgi.enterprise-${PV}.jar from"
	einfo "  http://www.osgi.org/Download/Release5"
	einfo "which you can find listed as"
	einfo "  OSGi Enterprise Release 5 Companion Code"
	einfo "after accepting the license."
}

java_prepare() {
	rm -r org || die
}
