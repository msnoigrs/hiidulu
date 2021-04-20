# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/tumashu/company-posframe.git"

inherit elisp git-r3

DESCRIPTION="a company extension, which let company use child frame"
HOMEPAGE="https://github.com/tumashu/company-posframe"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/posframe
	app-emacs/company-mode
	app-emacs/company-quickhelp"
RDEPEND="${DEPEND}"
