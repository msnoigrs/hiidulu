# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/dominikh/go-errcheck.el.git"

inherit elisp git-r3

DESCRIPTION="an easy way to invoke errcheck from within Emacs"
HOMEPAGE="https://github.com/dominikh/go-errcheck.el"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	dev-util/errcheck"

#SITEFILES="50${PN}-gentoo.el"
