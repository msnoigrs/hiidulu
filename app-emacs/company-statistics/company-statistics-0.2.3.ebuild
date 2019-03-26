# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit elisp

DESCRIPTION="Sort completion candidates by previous completion choices"
HOMEPAGE="https://company-mode.github.com/"
COMMIT="e62157d43b2c874d2edbd547c3bdfb05d0a7ae5c"
SRC_URI="https://github.com/company-mode/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

DOCS="README.org"

DEPEND="app-emacs/company-mode"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${COMMIT}"
