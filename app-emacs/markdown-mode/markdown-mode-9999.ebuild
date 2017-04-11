# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/jrblevin/markdown-mode.git"

inherit elisp git-r3

DESCRIPTION="Major mode for editing Markdown-formatted text files"
HOMEPAGE="http://jblevins.org/projects/markdown-mode/"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

RDEPEND="|| ( dev-python/markdown2 dev-python/markdown )"

#SITEFILE="50${PN}-gentoo.el"
#ELISP_PATCHES="${PN}-2.1-text-auto-mode.patch"
