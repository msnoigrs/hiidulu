# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/0x60df/ox-qmd.git"

inherit elisp git-r3

DESCRIPTION="Qiita Markdown Back-End for Org Export Engine"
HOMEPAGE="https://github.com/0x60df/ox-qmd"

DEPEND="app-emacs/request"
RDEPEND="${DEPEND}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
