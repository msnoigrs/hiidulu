# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/Malabarba/spinner.el.git"

inherit elisp git-r3

DESCRIPTION="Emacs mode-line spinner for operations in progress"
HOMEPAGE="https://github.com/Malabarba/spinner.el"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-emacs/dash"
RDEPEND="${DEPEND}"
