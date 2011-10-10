# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit java-virtuals-2

DESCRIPTION="Virtual for servlet api"
HOMEPAGE="http://java.sun.com/products/servlet/"
SRC_URI=""

LICENSE="as-is"
SLOT="${PV}"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| (
		dev-java/tomcat-servlet-api:${SLOT}
		dev-java/resin-servlet-api:${SLOT}
	)"
DEPEND=""

JAVA_VIRTUAL_PROVIDES="resin-servlet-api-${SLOT} tomcat-servlet-api-${SLOT}"
