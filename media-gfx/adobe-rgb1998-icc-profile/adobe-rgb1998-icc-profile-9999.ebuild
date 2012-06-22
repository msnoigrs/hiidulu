# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Adobe RGB (1998) color image encoding"
HOMEPAGE="http://www.adobe.com/digitalimag/adobergb.html"
SRC_URI="AdobeICCProfilesCS4Win_end-user.zip"

LICENSE="public-domain" # fake
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~mips ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND=""

S="${WORKDIR}"

src_prepare() {
	mv Adobe* "${PN}"
}

src_install() {
	cd "${PN}"
	dodir /usr/share/color/icc/AdobeICCProfiles
	dodir /usr/share/color/icc/AdobeICCProfiles/RGB
	dodir /usr/share/color/icc/AdobeICCProfiles/CMYK
	insinto /usr/share/color/icc/AdobeICCProfiles/RGB
	for i in RGB/*.icc; do
		doins "${i}"
	done
	insinto /usr/share/color/icc/AdobeICCProfiles/CMYK
	for i in CMYK/*.icc; do
		doins "${i}"
	done
}
