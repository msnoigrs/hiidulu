# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI="https://github.com/remyferre/comment-dwim-2.git"

inherit elisp git-2

DESCRIPTION="comment-dwim-2 is a replacement for the Emacs"
HOMEPAGE="https://github.com/remyferre/comment-dwim-2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	rm -v ${S}/comment-dwim-2-test.el
}
