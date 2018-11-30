# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod git-r3

EGIT_REPO_URI="https://github.com/jwrdegoede/vboxsf.git"

DESCRIPTION="Linux vboxsf driver"
HOMEPAGE="https://github.com/jwrdegoede/vboxsf/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="CC=$(tc-getBUILD_CC) KERN_DIR=${KV_DIR} KERN_VER=${KV_FULL} O=${KV_OUT_DIR} V=1 KBUILD_VERBOSE=1"
}

src_compile() {
	emake
}

src_install() {
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
