# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://git.sr.ht/~bzg/org-contrib"

inherit elisp git-r3

DESCRIPTION="add-ns to Org"
HOMEPAGE="http://www.orgmode.org/"

LICENSE="GPL-2 MIT as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~x86-macos"
IUSE=""

DEPEND="app-emacs/org-mode"

S="${WORKDIR}/${P}/lisp"
