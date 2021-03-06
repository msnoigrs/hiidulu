# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/iRi-E/mozc-el-extensions.git"

inherit elisp git-r3

DESCRIPTION="mozc.el extensions"
HOMEPAGE="https://github.com/iRi-E/mozc-el-extensions"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-i18n/mozc"
RDEPEND="${DEPEND}"
