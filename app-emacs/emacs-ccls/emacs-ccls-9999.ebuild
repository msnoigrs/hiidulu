# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/MaskRay/emacs-ccls.git"

inherit elisp git-r3

DESCRIPTION="Emacs client for ccls, a C/C++ language server"
HOMEPAGE="https://github.com/MaskRay/emacs-ccls"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/ccls"
RDEPEND="${DEPEND}"
