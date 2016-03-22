# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/syohex/emacs-go-direx.git"

inherit elisp git-2

DESCRIPTION="Tree style source code viewer for Go language"
HOMEPAGE="https://github.com/syohex/emacs-go-direx"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emacs/direx-el"
RDEPEND="${DEPEND}
	dev-go/gotags"

#SITEFILES="50${PN}-gentoo.el"
