# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

EGIT_REPO_URI="https://github.com/yhat/ggplot.git"

inherit distutils-r1 git-r3

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
