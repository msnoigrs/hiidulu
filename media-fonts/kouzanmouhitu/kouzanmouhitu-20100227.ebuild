# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

DESCRIPTION="kouzan mouhitu fonts"
HOMEPAGE="http://musashi.or.tv/kouzanmouhitufont.htm"
SRC_URI="http://anzawa.ps.land.to/bin/KouzanMouhituFontOTF.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"
FONT_SUFFIX="otf"
FONT_S="${S}"

# Only installs fonts
RESTRICT="strip binchecks"
