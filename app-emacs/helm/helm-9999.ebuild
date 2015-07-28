# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://github.com/emacs-helm/helm.git"

inherit elisp git-2

DESCRIPTION="incremental completion and selection narrowing framework"
HOMEPAGE="https://github.com/emacs-helm/helm"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	emake
}
