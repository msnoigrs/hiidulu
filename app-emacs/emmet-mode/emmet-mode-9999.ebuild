# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/smihica/emmet-mode.git"

inherit elisp git-r3

DESCRIPTION="emmet's support for emacs"
HOMEPAGE="http://www.emacswiki.org/emacs/ZenCoding"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	sed -i -e 's/lang=en/lang=ja/g' conf/snippets.json
}

src_compile() {
	emake
}
