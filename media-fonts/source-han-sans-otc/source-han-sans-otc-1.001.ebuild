# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

EGIT_REPO_URI="https://code.google.com/p/noto/"

inherit font git-2

DESCRIPTION="Noto Sans CJK in OTC"
HOMEPAGE="https://github.com/adobe-fonts/source-han-sans"
SRC_URI="https://github.com/adobe-fonts/source-han-sans/archive/${PV}R.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

FONT_SUFFIX="ttc"
FONT_S="${S}/third_party/noto_cjk"
#FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"

# Only installs fonts
RESTRICT="strip bincheckes"