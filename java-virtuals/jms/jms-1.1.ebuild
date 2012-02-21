# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit java-virtuals-2

DESCRIPTION="Virtual for Java Message Service (JMS) API"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="|| (
			dev-java/geronimo-spec-jms:0
			dev-java/glassfish-jms-api:0
			dev-java/sun-jms:0
		)
		"

JAVA_VIRTUAL_PROVIDES="geronimo-spec-jms glassfish-jms-api sun-jms"
