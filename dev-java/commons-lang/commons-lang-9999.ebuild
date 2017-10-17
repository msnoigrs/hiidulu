# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc source"
EGIT_REPO_URI="https://github.com/apache/commons-lang.git"

inherit git-2 java-pkg-2 java-pkg-simple

DESCRIPTION="Commons components to manipulate core java classes"
HOMEPAGE="http://commons.apache.org/lang/"
SRC_URI=""
IUSE=""

DEPEND=">=virtual/jdk-1.7"
RDEPEND=">=virtual/jre-1.7"

LICENSE="Apache-2.0"
SLOT="3.0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

JAVA_SRC_DIR="src/main/java"
