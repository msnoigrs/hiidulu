# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/company-mode/company-mode.git"

inherit elisp git-r3

DESCRIPTION="In-buffer completion front-end"
HOMEPAGE="https://company-mode.github.com/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

DOCS="README.md NEWS.md"
