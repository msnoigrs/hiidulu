# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

ANT_TASK_DEPNAME=""
ANT_TASK_DISABLE_VM_DEPS="true"

# contains the tasks depending on 1.5 java
#ANT_TASK_JDKVER=1.5
#ANT_TASK_JREVER=1.5

# cannot hurt...
#JAVA_PKG_WANT_SOURCE=1.5
#JAVA_PKG_WANT_TARGET=1.5

inherit ant-tasks

DESCRIPTION="Apache Ant's optional tasks requiring no external deps"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=">=virtual/jdk-1.5" #jar

#src_unpack() {
#	ant-tasks_src_unpack base
#	java-pkg_jar-from --build-only ant-core ant-launcher.jar
#	java-pkg_filter-compiler jikes
#}

#src_compile() {
#	eant jar-nodeps
#}

src_compile() {
	# the classes were moved to ant-core in 1.8.2, this is just for compatibility
	mkdir -p build/lib/empty && cd build/lib/empty || die
	jar -cf ../${PN}.jar . || die
}

pkg_postinst() {
	elog "Upstream has removed ant-nodeps.jar as of 1.8.2 and moved the classes to ant.jar"
	elog "This package thus installs an empty jar for compatibility"
	elog "and will be removed once reverse dependencies are transitioned."
}
