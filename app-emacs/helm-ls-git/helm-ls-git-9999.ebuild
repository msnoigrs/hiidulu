# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/emacs-helm/helm-ls-git.git"

inherit elisp git-r3

DESCRIPTION="Yet another helm to list git file"
HOMEPAGE="https://github.com/emacs-helm/helm-ls-git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#SITEFILE="50${PN}-gentoo.el"
