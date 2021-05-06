# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/kiwanami/emacs-ctable.git"

inherit elisp git-r3

DESCRIPTION="Table Component for elisp"
HOMEPAGE="https://github.com/kiwanami/emacs-ctable"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	rm test-*.el
}
