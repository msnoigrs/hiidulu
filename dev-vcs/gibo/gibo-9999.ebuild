# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI="https://github.com/simonwhitaker/gibo.git"

inherit bash-completion-r1 eutils git-2

DESCRIPTION="fast access to .gitignore boilerplates"
HOMEPAGE="https://github.com/simonwhitaker/gibo"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="zsh-completion"

RDEPEND="dev-vcs/git
	app-shells/bash
	zsh-completion? ( app-shells/zsh )"
DEPEND=""

src_install() {
	dobin gibo
	newbashcomp gibo-completion.bash ${PN}
	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions
		doins gibo-completion.zsh
	fi
	dodoc README.md
}
