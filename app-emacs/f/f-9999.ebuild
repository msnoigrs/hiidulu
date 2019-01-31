# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/rejeep/f.el.git"

inherit elisp git-r3

DESCRIPTION="Modern API for working with files and directories in Emacs"
HOMEPAGE="https://github.com/rejeep/f.el"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/s"
RDEPEND="${DEPEND}"
