# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

EGIT_REPO_URI="https://github.com/yhat/ggplot.git"

inherit distutils-r1 git-2

DESCRIPTION="ggplot for python"
HOMEPAGE="http://blog.yhathq.com/posts/ggplot-for-python.html"
#SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/matplotlib
	dev-python/pandas
	dev-python/numpy
	dev-python/statsmodels"
RDEPEND="${DEPEND}"
