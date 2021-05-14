# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/magit/libegit2.git"

inherit elisp git-r3

DESCRIPTION="Emacs bindings for libgit2"
HOMEPAGE="https://github.com/magit/libegit2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/cmake
	dev-libs/libgit2"
RDEPEND="${DEPEND}"

src_compile() {
	emake
}

src_install() {
	elisp-install ${PN} libgit.el libgit.elc
	insinto "${SITELISP}/${PN}/build"
	doins build/libegit2.so
}
