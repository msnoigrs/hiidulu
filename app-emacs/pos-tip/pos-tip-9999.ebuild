# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/syohex/pos-tip.git"

inherit elisp git-r3

DESCRIPTION="Show tooltip at point"
HOMEPAGE="https://github.com/syohex/pos-tip"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

#SITEFILES="50${PN}-gentoo.el"

src_prepare() {
	sed -i -e "s/(interactive-p)/(called-interactively-p 'any)/" pos-tip.el
}
