# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/remyferre/comment-dwim-2.git"

inherit elisp git-r3

DESCRIPTION="comment-dwim-2 is a replacement for the Emacs"
HOMEPAGE="https://github.com/remyferre/comment-dwim-2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ELISP_REMOVE="comment-dwim-2-test.el"
