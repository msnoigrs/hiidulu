# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit elisp autotools git-r3

EGIT_REPO_URI="https://github.com/purcell/mmm-mode"

DESCRIPTION="Enables the user to edit different parts of a file in different major modes"
HOMEPAGE="https://github.com/purcell/mmm-mode"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --with-emacs
}
