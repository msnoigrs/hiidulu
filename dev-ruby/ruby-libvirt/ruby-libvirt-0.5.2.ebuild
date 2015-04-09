# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

inherit ruby-fakegem

DESCRIPTION="Ruby bindings for libvirt."
HOMEPAGE="http://libvirt.org/ruby/"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="${DEPEND}
	app-emulation/libvirt"

each_ruby_configure() {
	${RUBY} -Cext/libvirt extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/libvirt || die "failed to compile"
	cp ext/libvirt/_libvirt.so lib/
}
