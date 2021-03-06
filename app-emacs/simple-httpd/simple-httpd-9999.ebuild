# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/skeeto/emacs-web-server.git"

inherit elisp git-r3

DESCRIPTION="A simple Emacs web server"
HOMEPAGE="https://github.com/skeeto/emacs-web-server"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#SITEFILE="50${PN}-gentoo.el"
