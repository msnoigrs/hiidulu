# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

TEXLIVE_MODULE_CONTENTS="amsfonts bibtex cm dvipdfmx-def enctex etex etex-pkg hyph-utf8 ifluatex ifxetex knuth-lib knuth-local lua-alt-getopt luatex makeindex metafont mflogo mfware pdftex plain tex texlive-common texlive-docindex texlive-en texlive-msg-translations texlive-scripts collection-basic
"
TEXLIVE_MODULE_DOC_CONTENTS="amsfonts.doc bibtex.doc cm.doc enctex.doc etex.doc etex-pkg.doc hyph-utf8.doc ifluatex.doc ifxetex.doc lua-alt-getopt.doc luatex.doc makeindex.doc metafont.doc mflogo.doc mfware.doc pdftex.doc tex.doc texlive-common.doc texlive-docindex.doc texlive-en.doc texlive-scripts.doc "
TEXLIVE_MODULE_SRC_CONTENTS="amsfonts.source hyph-utf8.source ifluatex.source ifxetex.source mflogo.source "
inherit  texlive-module
SRC_URI=""
for i in ${TEXLIVE_MODULE_CONTENTS}; do
	SRC_URI="${SRC_URI} http://dev.gentoo.gr.jp/~igarashi/distfiles/texlive-module-${i}-${PV}.${PKGEXT}"
done

DESCRIPTION="TeXLive Essential programs and files"

LICENSE=" GPL-1 GPL-2 LPPL-1.3 OFL TeX TeX-other-free "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND="!<app-text/texlive-core-2009
!<dev-texlive/texlive-latex-2009
!<dev-texlive/texlive-latexrecommended-2009
!dev-texlive/texlive-documentation-base
"
RDEPEND="${DEPEND} "
#PATCHES=( "${FILESDIR}/texmfcnflua2014.patch" )
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/simpdftex/simpdftex texmf-dist/scripts/texlive/rungs.tlu"
DEPEND="${DEPEND}
!!<dev-texlive/texlive-langcjk-2011
!!<dev-texlive/texlive-langother-2012
!!<dev-texlive/texlive-langgerman-2013
!!<dev-texlive/texlive-langgreek-2013
"

src_unpack() {
	unpack ${A}

	#sed -i -e '/mflogo.map/ d' tlpkg/tlpobj/mflogo.tlpobj || die
	sed -i -e '/logosl9.tfm/ d' tlpkg/tlpobj/mflogo.tlpobj || die
	#sed -i -e '/logo.mf/ d' tlpkg/tlpobj/mflogo.tlpobj || die

	grep RELOC tlpkg/tlpobj/* | awk '{print $2}' | sed 's#^RELOC/##' > "${T}/reloclist"
	{ for i in $(<"${T}/reloclist"); do  dirname $i; done; } | uniq > "${T}/dirlist"
	for i in $(<"${T}/dirlist"); do
		[ -d "${RELOC_TARGET}/${i}" ] || mkdir -p "${RELOC_TARGET}/${i}"
	done
	for i in $(<"${T}/reloclist"); do
		mv "${i}" "${RELOC_TARGET}"/$(dirname "${i}") || die "failed to relocate ${i} to ${RELOC_TARGET}/$(dirname ${i})"
	done
}
