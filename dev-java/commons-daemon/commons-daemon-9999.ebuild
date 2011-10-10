# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
ESVN_REPO_URI="http://svn.apache.org/repos/asf/commons/proper/daemon/trunk"
WANT_AUTOCONF=2.5
JAVA_PKG_IUSE="doc examples source"

inherit subversion java-pkg-2 java-ant-2 eutils autotools

DESCRIPTION="Tools to allow java programs to run as unix daemons"
HOMEPAGE="http://commons.apache.org/daemon/"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
#KEYWORDS="amd64 ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE="doc examples source"

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

java_prepare() {
	# Submitted upstream to http://bugs.gentoo.org/show_bug.cgi?id=132563
	#epatch "${FILESDIR}/1.0.1-as-needed-2.patch"

	# https://issues.apache.org/jira/browse/DAEMON-93
	#epatch "${FILESDIR}/1.0.1-capabilities-non-root-2.patch"

	#epatch "${FILESDIR}/add-log-rotation-support.patch"
	#epatch "${FILESDIR}/svn-add-log-rotation-support.patch"

	cd "${S}/src/native/unix"
	sed -e "s/powerpc/powerpc|powerpc64/g" -i support/apsupport.m4
	eautoconf
}

src_configure() {
	java-ant-2_src_configure
	cd "${S}/src/native/unix"
	econf || die "configure failed"
}

src_compile() {
	# compile native stuff
	cd "${S}/src/native/unix"
	emake || die "make failed"

	# compile java stuff
	cd "${S}"
	eant jar $(use_doc)
}

src_install() {
	dobin src/native/unix/jsvc
	java-pkg_newjar dist/${PN}*.jar

	dodoc README RELEASE-NOTES.txt *.html
	use doc && java-pkg_dohtml -r dist/docs/*
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -R src/samples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/java/* src/native/unix/native
}
