# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_3} )

inherit distutils-r1

DESCRIPTION="Python web framework and asynchronous networking library"
HOMEPAGE="http://www.tornadoweb.org/ https://github.com/facebook/tornado https://pypi.python.org/pypi/tornado"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="curl test"

RDEPEND="curl? ( dev-python/pycurl )
	virtual/python-json"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/unittest2 )"

src_prepare() {
	distutils-r1_src_prepare

	# Avoid test failures with unittest2 and Python >=2.7.
	sed \
		-e "51s/try:/if __import__(\"sys\").version_info < (2, 7):/" \
		-e "53s/except ImportError:/else:/" \
		-i tornado/testing.py

	# Disable tests failing with PycURL and Python 3.
	sed -e "/^    def test_body_encoding(/a \\        if __import__(\"sys\").version_info >= (3, 0): self.skipTest(\"test broken with PycURL and Python 3\")" -i tornado/test/httpclient_test.py
	sed -e "/^    def test_digest_auth(/a \\        if __import__(\"sys\").version_info >= (3, 0): self.skipTest(\"test broken with PycURL and Python 3\")" -i tornado/test/curl_httpclient_test.py
}

#src_test() {
#	testing() {
#		python_execute PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" -m tornado.test.runtests
#	}
#	python_execute_function testing
#}

src_install() {
	distutils-r1_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/tornado/test"
	}
	python_foreach_impl delete_tests
}
