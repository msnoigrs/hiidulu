# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/abo-abo/hydra.git"

inherit elisp git-r3

DESCRIPTION="make Emacs bindings that stick around"
HOMEPAGE="https://github.com/abo-abo/hydra"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	elisp-install ${PN} hydra-ox.el hydra-ox.elc hydra.el hydra.elc lv.el lv.elc
}
