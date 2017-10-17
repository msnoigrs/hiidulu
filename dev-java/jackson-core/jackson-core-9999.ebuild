# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="https://github.com/FasterXML/jackson-core.git"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="High-performance JSON processor"
HOMEPAGE="http://jackson.codehaus.org"

LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.8"
DEPEND=">=virtual/jdk-1.8"

java_prepare() {
	cp "${FILESDIR}"/gentoo-build.xml "${S}"/build.xml || die

	sed -e 's:@package@:com.fasterxml.jackson.core.json:g' \
		-e "s:@projectversion@:${PV}:g" \
		-e 's:@projectgroupid@:com.fasterxml.jackson.core:g' \
		-e 's:@projectartifactid@:jackson-core:g' \
		"${S}/src/main/java/com/fasterxml/jackson/core/json/PackageVersion.java.in" \
		> "${S}/src/main/java/com/fasterxml/jackson/core/json/PackageVersion.java" || die
}

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs/
	use source && java-pkg_dosrc src/main/java/*
}
