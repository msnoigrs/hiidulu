# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI=""

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION=""
HOMEPAGE="https://github.com/Atmosphere/atmosphere/wiki"

LICENSE="Apache-2.0"
SLOT="6.0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5
	java-virtuals/servlet-api:3.0
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
