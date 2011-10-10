# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: java-modello-utils.eclass
# @MAINTAINER:
# IGARASHI Masanao <igarashi@gentoo.gr.jp>
#
# Original Author: IGARASHI Masanao <igarashi@gentoo.gr.jp>
#
# @BLURB: Eclass for building dev-java/modello-* packages
# @DESCRIPTION:
# Modello Utility eclass

inherit java-utils-2

# ------------------------------------------------------------------------------
# @public java-modello_register-modello-plugin
# ------------------------------------------------------------------------------
java-modello_register-modello-plugin() {
	local PLUGINS_DIR="plugins"

	# check for --version x.y parameters
	while [ -n "${1}" -a -n "${2}" ]; do
		local var="${1#--}"
		local val="${2}"
		if [ "${var}" = "version" ]; then
			PLUGINS_DIR="plugins-${val}"
		else
			die "Unknown parameter passed to java-modello_register-plugin: ${1} ${2}"
		fi
		shift 2
	done

	local PLUGIN_NAME="${1:-${JAVA_PKG_NAME}}"

	dodir /usr/share/modello/${PLUGINS_DIR}
	touch "${D}/usr/share/modello/${PLUGINS_DIR}/${PLUGIN_NAME}"
}
