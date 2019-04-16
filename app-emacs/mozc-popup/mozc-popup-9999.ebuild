# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/d5884/mozc-popup.git"

inherit elisp git-r3

DESCRIPTION="using mozc.el with popup"
HOMEPAGE="https://github.com/d5884/mozc-popup"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-i18n/mozc
	app-emacs/popup-el"
RDEPEND="${DEPEND}"
