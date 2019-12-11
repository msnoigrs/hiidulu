# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/company-mode/company-quickhelp.git"

inherit elisp git-r3

DESCRIPTION="Documentation popup for Company"
HOMEPAGE="https://github.com/company-mode/company-quickhelp"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/company-mode"
RDEPEND="${DEPEND}"
