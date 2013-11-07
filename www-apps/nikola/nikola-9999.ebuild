# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_3} )
inherit distutils-r1

DESCRIPTION="A static website and blog generator"
HOMEPAGE="http://nikola.ralsina.com.ar/"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/getnikola/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/getnikola/nikola/archive/v{PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT-with-advertising"
SLOT="0"
IUSE="jinja markdown bbcode livereload pyphen"

DEPEND="dev-python/docutils" # needs rst2man to build manpage
RDEPEND="${DEPEND}
	>=dev-python/doit-0.20.0
	virtual/python-imaging
	dev-python/lxml
	>=dev-python/mako-0.6
	>=dev-python/mock-1.0.0
	dev-python/pygments
	dev-python/PyRSS2Gen
	dev-python/requests
	dev-python/unidecode
	=dev-python/yapsy-1.10.2
	=dev-python/pytz-2013d
	dev-python/python-dateutil
	dev-python/micawber
	dev-python/Pyphen
	dev-python/blinker
	dev-python/logbook
	bbcode? ( dev-python/bbcode )
	livereload? ( dev-python/livereload )
	pyphen? ( dev-python/Pyphen )
	jinja? ( dev-python/jinja )
	markdown? ( dev-python/markdown )"

src_install() {
	distutils-r1_src_install

	# hackish way to remove docs that ended up in the wrong place
	rm -rf "${D}"/usr/share/doc/${PN}

	dodoc AUTHORS.txt CHANGES.txt README.rst docs/*.txt
}

pkg_postinst() {
	if has_version '<www-apps/nikola-5.0'; then
		elog 'Nikola has changed quite a lot since the previous major version.'
		elog 'Please make sure to read the updated documentation.'
	fi
}
