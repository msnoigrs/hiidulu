# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI="https://github.com/dunamis1974/pgaccess.git"

inherit eutils git-2

DESCRIPTION="PgAccess is a graphical interface to PostgreSQL database"
HOMEPAGE="https://github.com/dunamis1974/pgaccess"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-lang/tk
	dev-tcltk/tcllib
	dev-tcltk/tablelist
	dev-tcltk/bwidget"
DEPEND=""

src_prepare() {
	sed -i -e "s#/usr/lib#/usr/share/${PN}/lib#" pgaccess.tcl
	sed -i -e '/^set PgAcVar(MAIN_VERSION)/ i set PgAcVar(PGACCESS_HOME) "/usr/share/'"${PN}"'"' pgaccess.tcl
	#sed -i -e "s/tablelist 3.3/tablelist 5.8/" pgaccess.tcl
	sed -i -e "s/tablelist 3.3/tablelist/" pgaccess.tcl
	sed -i -e "s/BWidget 1.6.0/BWidget/" pgaccess.tcl

	mv pgaccess.tcl pgaccess
}

src_compile() { :; }

src_install() {
	insinto /usr/share/${PN}/lib
	doins lib/*
	insinto /usr/share/${PN}/images
	doins images/*

	dobin pgaccess
}
