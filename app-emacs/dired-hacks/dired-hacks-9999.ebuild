# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/Fuco1/dired-hacks.git"

inherit elisp git-2

DESCRIPTION="Collection of userful dired additions"
HOMEPAGE="https://github.com/Fuco1/dired-hacks"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emacs/dash"
RDEPEND="${DEPEND}"

src_prepare() {
	rm dired-columns.el
}
