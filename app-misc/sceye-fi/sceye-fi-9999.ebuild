# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

ESVN_REPO_URI="http://sceye-fi.googlecode.com/svn/trunk"
JAVA_PKG_IUSE=""

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="A server for Eye-Fi cards written in Java"
HOMEPAGE="https://code.google.com/p/sceye-fi/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEP="dev-java/jdom:1.0"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

java_prepare() {
	rm -fv capture/lib/*.jar
	java-pkg_jar-from --into capture/lib jdom-1.0 jdom.jar

	cd capture
	sed -i -e 's#Application Data/Eye-Fi#eyefi#' src/org/tastefuljava/sceyefi/capture/conf/EyeFiConf.java
}

src_compile() {
	cd capture
	java-pkg-2_src_compile
}

src_install() {
	cd capture

	java-pkg_dojar dist/sceye-fi.jar
	java-pkg_dolauncher ${PN} --java_args "-Djava.util.logging.config.file="'${HOME}'"/eyefi/logging.properties" \
		--main org.tastefuljava.sceyefi.capture.Main
}
