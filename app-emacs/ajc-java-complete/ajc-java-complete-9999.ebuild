# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://github.com/jixiuf/ajc-java-complete.git"

inherit elisp java-pkg-2 java-ant-2 git-2

DESCRIPTION="Auto Java Complete"
HOMEPAGE="http://www.emacswiki.org/emacs/AutoJavaComplete"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEP="app-emacs/yasnippet
	app-emacs/popup-el
	app-emacs/auto-complete"
DEPEND="${COMMON_DEP}
	app-arch/zip"
RDEPEND="${COMMON_DEP}"

SITEFILE="51${PN}-gentoo.el"

src_unpack() {
	git-2_src_unpack

	rm ${S}/popup-patch.diff ${S}/popup.el || die
}

src_compile() {
	elisp_src_compile

	ejavac -encoding UTF-8 Tags.java
	jar cf ajc.jar *.class || die "jar fail"
}

src_install() {
	elisp_src_install

	java-pkg_dojar ajc.jar

	dodoc README.txt || die "dodoc failed"
	java-pkg_dosrc Tags.java

	insinto "${SITEETC}/${PN}"
	doins java_base.tag.bz2 || die
}

pkg_postinst() {
	elisp-site-regen

	elog "Please make a tag file at your home directory"
	elog "bzcat ${SITEETC}/${PN}/java_base.tag.bz2 > ~/.java_base.tag"
}
