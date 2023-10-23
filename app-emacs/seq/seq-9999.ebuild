# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/NicolasPetton/seq.el.git"

inherit elisp git-r3

DESCRIPTION="Sequence manipulation library for Emacs"
HOMEPAGE="https://github.com/NicolasPetton/seq.el"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

#SITEFILES="50${PN}-gentoo.el"
