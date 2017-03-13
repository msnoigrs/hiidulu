# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGIT_REPO_URI="https://github.com/aarond10/https_dns_proxy"

inherit cmake-multilib git-r3

DESCRIPTION="a non-caching proxy for Google's DNS-over-HTTPS service."
HOMEPAGE="https://github.com/aarond10/https_dns_proxy"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-dns/c-ares
	net-misc/curl
	dev-libs/libev"
RDEPEND="${DEPEND}"

multilib_src_install() {
	#default

	dosbin ${BUILD_DIR}/${PN//-/_}
}
# 	dosbin ${PN}
# 	keepdir /var/empty

# 	newconfd "${FILESDIR}"/${PN}.confd ${PN}
# 	newinitd "${FILESDIR}"/${PN}.initd ${PN}
# 	insinto /etc/${PN}
# 	newins ${PN}.conf ${PN}.conf.dist

# 	dodoc README
# 	doman ${PN}.1
# }
