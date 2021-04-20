# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/m2ym/popwin-el.git"

inherit elisp git-r3

DESCRIPTION="Auto-complete package"
HOMEPAGE="http://github.com/m2ym/popwin-el"
SRC_URI=""

LICENSE="GPL-3 FDL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SITEFILE="50${PN}-gentoo.el"

src_install() {
	elisp_src_install
	elisp-install ${PN} misc/*.el || die
}
