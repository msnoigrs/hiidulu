# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/skeeto/emacs-web-server.git"

inherit elisp git-2

DESCRIPTION="A simple Emacs web server"
HOMEPAGE="https://github.com/skeeto/emacs-web-server"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#SITEFILE="50${PN}-gentoo.el"
