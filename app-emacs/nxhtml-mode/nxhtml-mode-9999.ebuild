# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

EBZR_REPO_URI="lp:nxhtml"

inherit elisp eutils bzr

DESCRIPTION="A major mode for GNU Emacs for editing XHTML documents."
HOMEPAGE="http://ourcomments.org/Emacs/nXhtml/doc/nxhtml.html"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

#	app-emacs/wikipedia-mode
#	app-emacs/snippet
#	app-emacs/find-recursive
#	app-emacs/cgi+

EL_DEPEND="|| ( app-emacs/nxml-mode >=virtual/emacs-23 )
	!app-emacs/php-mode
	>=app-emacs/csharp-mode-0.7.6
	app-emacs/js2-mode
	!app-emacs/smarty-mode"

DEPEND="${EL_DEPEND}
	app-arch/unzip"
RDEPEND="${EL_DEPEND}
	net-misc/ftpsync"

# Must come after nxml
SITEFILE=60${PN}-gentoo.el

src_prepare() {
	find . -type f \
		-exec chmod -x {} + \
		-exec sed -i -e 's:\r$::' {} +

	# Removing contributed code, most of this stuff is added as
	# dependencies already.
	#
	# moz.el should be removed if we were to package mozrepl

	rm autostart22.el emacs22.cmd || die "unable to remove"

	cd "${S}/related"

	sed -i -e 's#c:/emacs/p/091105/EmacsW32/nxhtml/related/#usr/share/emacs/nxhtml-mode/related/#' rhino.js
	sed -i -e 's#c:/Sun/SDK/jdk/bin/javac.exe#/usr/bin/javac#' flymake-for-java.el

	rm csharp-mode.el iss-mode.el iss-mumamo.el \
		|| die "unable to remove contrib code"
	# rm csharp-mode.el fold-dwim.el javascript.el php-mode.el \
	# 	php-imenu.el smarty-mode.el tt-mode.el wikipedia-mode.el \
	# 	"${S}"/util/htmlfontify.21.el "${S}"/nxhtml/outline-magic.el \
	# 	|| die "unable to remove contrib code"

	# sed -i -e 's:\([^(]\)javascript-mode:\1js2-fl-mode:' \
	# 	"${S}"/util/mumamo.el || die "unable to replace javascript-mode"
}

src_compile() {
	# Regenerate the autoload code.
#	emacs -L $(pwd) --batch --script nxhtmlmaint.el -f nxhtmlmaint-get-all-autoloads \
#		|| die "nxhtml-loaddefs.el regen failed"

	emacs --batch --no-site-file -f batch-byte-compile nxhtml-base.el

	emacs --batch --no-site-file -L ./ -L nxhtml/ -L util/ -L related/ \
		-f batch-byte-compile \
		autostart.el nxhtml-loaddefs.el nxhtml/*.el util/*.el related/*.el
}

src_install() {
	#elisp-install ${PN} autostart.el{,c} nxhtml-loaddefs.el{,c}
	elisp-install ${PN} *.el{,c}
	for dir in nxhtml util related; do
		elisp-install ${PN}/${dir} ${dir}/*.el{,c} || die "elisp-install in ${dir} failed."
	done
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dodoc README.txt
	dohtml -r nxhtml/doc/*

	cd "${S}/nxhtml"
	exeinto /usr/libexec/emacs/${PN}
	doexe html-chklnk/link_checker.pl html-wtoc/html-wtoc.pl
	doexe html-upl/ftpsync.pl
	insinto /usr/libexec/emacs/${PN}/PerlLib
	doins -r html-chklnk/PerlLib/* html-wtoc/PerlLib/html_tags.pm
}

pkg_postinst () {
	elisp-site-regen

	if [ $(emacs -batch -q --eval "(princ (fboundp 'nxml-mode))") = nil ]; then
		ewarn "This package needs nxml-mode. You should either install"
		ewarn "app-emacs/nxml-mode, or use \"eselect emacs\" to select"
		ewarn "an Emacs version >= 23."
	fi
}
