# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MY_P="${PN}-v_${PV}"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="java library for writing localized messages using resource bundle"
HOMEPAGE="http://cal10n.qos.ch/"
SRC_URI="https://github.com/qos-ch/cal10n/archive/v_0.8.1.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"

S="${WORKDIR}/${MY_P}"

JAVA_ENCODING="ISO-8859-1"

java_prepare() {
	find -name '*Test.java' -exec rm {} \;
	find -name '*Perftest.java' -exec rm {} \;
	find -name '*Mojo.java' -exec rm {} \;
}
