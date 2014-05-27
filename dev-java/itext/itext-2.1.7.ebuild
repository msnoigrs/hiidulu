# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
JAVA_PKG_IUSE="doc source"
JAVA_ANT_ENCODING="utf-8"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Java library that generate documents in the Portable Document Format (PDF) and/or HTML."
HOMEPAGE="http://www.lowagie.com/iText/"
DISTFILE="${PN/it/iT}-src-${PV}.tar.gz"
ASIANJAR="iTextAsian.jar"
ASIANCMAPSJAR="iTextAsianCmaps.jar"
#mirror://sourceforge/itext/${DISTFILE}
#SRC_URI="https://github.com/masayuko/hiidulu/raw/master/distfiles/${DISTFILE}
SRC_URI="http://dev.gentoo.gr.jp/~igarashi/distfiles/${DISTFILE}
	cjk? ( mirror://sourceforge/itext/${ASIANJAR}
		mirror://sourceforge/itext/${ASIANCMAPSJAR} )"

LICENSE="|| ( MPL-1.1 LGPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"
#IUSE="cjk rtf rups"
IUSE="cjk rtf"

COMMON_DEPEND="dev-java/bcmail:1.49
	dev-java/bcprov:1.49
	dev-java/bcpkix:1.49"
DEPEND=">=virtual/jdk-1.6
	cjk? ( app-arch/unzip )
	 ${COMMON_DEPEND}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEPEND}"

BCV="1.38"

S="${WORKDIR}/src"

src_unpack() {
	unpack ${DISTFILE}
	cd "${S}"

	if use cjk; then
		cp "${DISTDIR}/${ASIANJAR}" "${DISTDIR}/${ASIANCMAPSJAR}" "${WORKDIR}" \
			|| die "Could not copy asian fonts"
	fi
}

java_prepare() {
	epatch "${FILESDIR}"/syoux2.patch
	epatch "${FILESDIR}"/itext-2.1.5-pdftk.patch
	epatch "${FILESDIR}"/itext-bcprov149.patch

	#find -name '*.java' -exec sed -i -e 's/DERObject$/ASN1Primitive/g' {} \;
	#find -name '*.java' -exec sed -i -e 's/DERObject /ASN1Primitive /g' {} \;
	#find -name '*.java' -exec sed -i -e 's/DERObject;/ASN1Primitive;/g' {} \;
	#find -name '*.java' -exec sed -i -e 's/(DERObject)/(ASN1Primitive)/g' {} \;
	#find -name '*.java' -exec sed -i -e 's/(DERString)/(ASN1String)/g' {} \;
	#find -name '*.java' -exec sed -i -e 's/DERString;/ASN1String;/g' {} \;
	#find -name '*.java' -exec sed -i -e 's/ASN1Encodable;/ASN1Object;/g' {} \;
	#find -name '*.java' -exec sed -i -e 's/ASN1Encodable.DER/org.bouncycastle.asn1.ASN1Encoding.DER/g' {} \;
	#find -name '*.java' -exec sed -i -e 's/getDERObject/toASN1Primitive/g' {} \;
	#sed -i -e 's/EnvelopedData(null, derset, encryptedcontentinfo, null)/EnvelopedData(null, derset, encryptedcontentinfo, (org.bouncycastle.asn1.ASN1Set)null)/' core/com/lowagie/text/pdf/PdfPublicKeySecurityHandler.java

	sed -i -e 's/jdk14/jdk16/' ant/.ant.properties

	sed -i -e 's|<link href="http://java.sun.com/j2se/1.4/docs/api/" />||' \
		-e 's|<link href="http://www.bouncycastle.org/docs/docs1.4/" />||' \
		"${S}/ant/site.xml"

	java-ant_bsfix_files ant/*.xml || die "failed to rewrite build xml files"

	mkdir -p "${WORKDIR}/lib" || die "Failed to create ${WORKDIR}/lib"
	cd "${WORKDIR}/lib" || die "Could not cd ${WORKDIR}/lib"
	java-pkg_jar-from bcmail-1.49 bcmail.jar "bcmail-jdk16-${BCV/./}.jar"
	java-pkg_jar-from bcprov-1.49 bcprov.jar "bcprov-jdk16-${BCV/./}.jar"
	java-pkg_jar-from bcpkix-1.49 bcpkix.jar "bctsp-jdk16-${BCV/./}.jar"
	#if use rups; then
	#	java-pkg_jar-from dom4j-1 dom4j.jar "dom4j-1.6.1.jar"
	#	EANT_GENTOO_CLASSPATH="pdf-renderer"
	#fi
}

JAVA_ANT_REWRITE_CLASSPATH="true"

src_compile() {
	java-pkg-2_src_compile \
		$(use rtf && echo "jar.rtf")
		#$(use rups && echo "jar.rups")
}

src_install() {
	cd "${WORKDIR}"
	java-pkg_dojar lib/iText.jar
	use rtf && java-pkg_dojar lib/iText-rtf.jar
	#use rups && java-pkg_dojar lib/iText-rups.jar
	if use cjk; then
		java-pkg_dojar "${ASIANJAR}"
		java-pkg_dojar "${ASIANCMAPSJAR}"
	fi

	#use source && java-pkg_dosrc src/core/com src/rups/com
	use source && java-pkg_dosrc src/core/com
	use doc && java-pkg_dojavadoc build/docs
}
