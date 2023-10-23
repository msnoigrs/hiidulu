# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/tigersoldier/company-lsp.git"

inherit elisp git-r3

DESCRIPTION="Company completion backend for lsp-mode"
HOMEPAGE="https://github.com/tigersoldier/company-lsp"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/dash
	app-emacs/s
	app-emacs/company-mode
	app-emacs/lsp-mode"
RDEPEND="${DEPEND}"
