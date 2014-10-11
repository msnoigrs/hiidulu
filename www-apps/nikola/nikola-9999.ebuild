# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="A static website and blog generator"
HOMEPAGE="http://nikola.ralsina.com.ar/"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/getnikola/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/getnikola/nikola/archive/v${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT-with-advertising"
SLOT="0"
IUSE="jinja markdown livereload pyphen"

DEPEND=">=dev-python/docutils-0.12" # needs rst2man to build manpage
RDEPEND="${DEPEND}
	>=dev-python/doit-0.23.0
	>=dev-python/pygments-1.6
	virtual/python-imaging
	>=dev-python/python-dateutil-2.2
	>=dev-python/mako-1.0.0
	>=dev-python/unidecode-0.04.16
	>=dev-python/lxml-3.3.5
	>=dev-python/yapsy-1.10.423
	>=dev-python/PyRSS2Gen-1.1
	>=dev-python/logbook-0.7.0
	>=dev-python/blinker-1.3
	>=dev-python/natsort-3.3.0
	dev-python/requests
	markdown? ( dev-python/markdown )
	jinja? ( dev-python/jinja )
	livereload? ( =dev-python/livereload-2.2.2 )
	pyphen? ( >=dev-python/pyphen-0.9.1 )
	dev-python/micawber
	=dev-python/pygal-1.5.1
	>=dev-python/typogrify-2.0.4
	>=dev-python/phpserialize-1.3
	dev-python/webassets"

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
