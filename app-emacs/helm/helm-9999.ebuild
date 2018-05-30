# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/emacs-helm/helm.git"

inherit elisp git-r3

DESCRIPTION="incremental completion and selection narrowing framework"
HOMEPAGE="https://github.com/emacs-helm/helm"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/async"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	emake
}
