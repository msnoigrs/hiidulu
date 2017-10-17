# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="source test"

EGIT_REPO_URI="https://github.com/apache/commons-lang.git"
EGIT_BRANCH="LANG_2_X"

inherit git-r3 java-pkg-2 java-pkg-simple

DESCRIPTION="Commons components to manipulate core java classes"
HOMEPAGE="http://commons.apache.org/lang/"
SRC_URI=""
IUSE=""

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

LICENSE="Apache-2.0"
SLOT="2.1"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

S="${WORKDIR}/${P}"
JAVA_SRC_DIR="src/main/java"
JAVA_ENCODING="iso-8859-1"

java_prepare() {
	rm -rf src/main/java/org/apache/commons/lang/enum
}
