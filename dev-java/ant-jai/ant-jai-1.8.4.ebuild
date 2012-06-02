# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

#ANT_TASK_DEPNAME="sun-jai-bin"
ANT_TASK_DEPNAME="jai-core"

inherit ant-tasks

KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

# unmigrated, has textrels and there's also some source one now too
#DEPEND=">=dev-java/sun-jai-bin-1.1.2.01-r1"
DEPEND="dev-java/jai-core"
RDEPEND="${DEPEND}"
