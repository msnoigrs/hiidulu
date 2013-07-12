# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"

JAVA_PKG_IUSE="source"
WANT_ANT_TASKS="ant-nodeps"

EGIT_REPO_URI="git://github.com/mauricio/jai-core.git"
#ESVN_REPO_URI="https://svn.java.net/svn/jai-core~svn/trunk"
# 1.3.9
#inherit subversion java-pkg-2 java-ant-2
inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION="The Java Advanced Imaging API Core"
HOMEPAGE="http://java.net/projects/jai-core/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEP=""
# needs com.sun.image.codec which 1.7 doesn't have
# should fix it to not use them at all
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

java_prepare() {
	rm src/share/classes/com/sun/media/jai/codec/ImageCodec.java
	rm src/share/classes/com/sun/media/jai/codecimpl/JPEGImageDecoder.java
	rm src/share/classes/com/sun/media/jai/codecimpl/JPEGImageEncoder.java
	rm src/share/classes/com/sun/media/jai/codecimpl/JPEGCodec.java
	rm src/share/classes/com/sun/media/jai/codecimpl/TIFFImage.java
	rm src/share/classes/com/sun/media/jai/codecimpl/TIFFImageEncoder.java
	rm src/share/classes/com/sun/media/jai/codecimpl/TIFFImageDecoder.java
	rm src/share/classes/com/sun/media/jai/codecimpl/FPXImageDecoder.java
	rm src/share/classes/com/sun/media/jai/codecimpl/fpx/FPXImage.java
	rm src/share/classes/com/sun/media/jai/opimage/IIPResolutionOpImage.java
	rm src/share/classes/com/sun/media/jai/tilecodec/JPEGTileDecoder.java
	rm src/share/classes/com/sun/media/jai/tilecodec/JPEGTileEncoder.java
	rm src/share/classes/com/sun/media/jai/tilecodec/JPEGTileDecoderFactory.java
	rm src/share/classes/com/sun/media/jai/tilecodec/JPEGTileEncoderFactory.java
#	epatch "${FILESDIR}/remove_jpegparam.patch"
}

src_compile() {
	local myarch="$(tc-arch)"
	if [[ ${myarch} = amd64 ]]; then
		EANT_EXTRA_ARGS="-DBUILD_TARGET=linux-amd64"
	elif [[ ${myarch} = x86 ]]; then
		EANT_EXTRA_ARGS="-DBUILD_TARGET=linux-x86"
	fi

	java-pkg-2_src_compile
}

src_install() {
	local myarch="$(tc-arch)"
	if [[ ${myarch} = amd64 ]]; then
		archpath="linux-amd64"
	elif [[ ${myarch} = x86 ]]; then
		archpath="linux-x86"
	fi

	java-pkg_dojar build/${archpath}/opt/lib/ext/jai_codec.jar
	java-pkg_dojar build/${archpath}/opt/lib/ext/jai_core.jar
	java-pkg_dojar build/${archpath}/opt/lib/ext/mlibwrapper_jai.jar

	java-pkg_doso build/${archpath}/opt/lib/${myarch}/libmlib_jai.so

	use source && java-pkg_dosrc src/share/classes/*
}
