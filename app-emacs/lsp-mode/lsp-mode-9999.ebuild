# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/emacs-lsp/lsp-mode.git"

inherit elisp git-r3

DESCRIPTION="Emacs client/library for the Language Server Protocol"
HOMEPAGE="https://github.com/emacs-lsp/lsp-mode"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/dash
	app-emacs/f
	app-emacs/ht
	app-emacs/spinner
	app-emacs/hydra"
RDEPEND="${DEPEND}"

src_compile() {
	emacs --batch --no-site-file -L . -L clients -f batch-byte-compile *.el clients/*.el
}

src_install() {
	elisp-install ${PN} *.el *.elc clients/*.el clients/*.elc
}
