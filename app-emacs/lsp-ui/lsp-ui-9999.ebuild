# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/emacs-lsp/lsp-ui.git"

inherit elisp git-r3

DESCRIPTION="The higher level UI modules of lsp-mode"
HOMEPAGE="https://github.com/emacs-lsp/lsp-ui"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/dash
	app-emacs/lsp-mode
	app-emacs/markdown-mode
	app-emacs/flycheck"
RDEPEND="${DEPEND}"
