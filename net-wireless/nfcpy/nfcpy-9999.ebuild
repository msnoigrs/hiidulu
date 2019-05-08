# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{6,7}} )
#DISTUTILS_SINGLE_IMPL=1

#EGIT_REPO_URI="https://github.com/nfcpy/nfcpy.git"
EGIT_REPO_URI="https://github.com/msnoigrs/nfcpy.git"
EGIT_BRANCH="py3stage2"

inherit git-r3 distutils-r1

DESCRIPTION="read/write NFC tags or communicate with another NFC device"
HOMEPAGE="https://github.com/nfcpy/nfcpy"

LICENSE="EUPL"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""

DEPEND="dev-python/libusb1
	dev-python/pyserial
	dev-python/ndeflib
	dev-python/pydes"
