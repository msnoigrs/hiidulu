# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/kiwanami/emacs-epc.git"

inherit elisp git-r3

DESCRIPTION="A RPC stack for Emacs Lisp"
HOMEPAGE="https://github.com/kiwanami/emacs-epc"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emacs/emacs-deferred
	app-emacs/emacs-ctable"
RDEPEND="${DEPEND}"

src_prepare() {
	rm test-*.el
}
