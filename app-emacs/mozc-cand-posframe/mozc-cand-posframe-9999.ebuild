# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/akirak/mozc-posframe.git"

inherit elisp git-r3

DESCRIPTION="Postframe frontend for mozc.el"
HOMEPAGE="https://github.com/arkirak/mozc-popup"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-i18n/mozc
	app-emacs/posframe
	!app-emacs/mozc-posframe"
RDEPEND="${DEPEND}"
