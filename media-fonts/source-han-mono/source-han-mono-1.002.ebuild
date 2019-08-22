# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_FONT_TYPES=( +ttc )
MY_PN="SourceHanMono"
if [[ -z ${PV%%*9999} ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/adobe-fonts/${PN}"
else
	SRC_URI="
		binary? (
		font_types_ttc? (
			https://github.com/adobe-fonts/${PN}/releases/download/${PV}/${MY_PN}.ttc
			-> ${MY_PN}-${PV}.ttc
		)
		)
	"
	RESTRICT="primaryuri"
	KEYWORDS="~amd64 ~x86"
fi
		# !binary? (
		# 	https://github.com/adobe-fonts/${PN}/archive/${PV}.tar.gz
		# 	-> ${P}.tar.gz
		# )


inherit font-r1

DESCRIPTION="A set of OpenType/CFF Pan-CJK fonts"
HOMEPAGE="https://source.typekit.com/${PN}"

LICENSE="OFL-1.1"
SLOT="0"
IUSE="+binary"
REQUIRED_USE="
?? ( ${MY_FONT_TYPES[@]/#+/} )
"

# DEPEND="
# 	!binary? ( dev-util/afdko )
# "

src_unpack() {
	if [[ ${PV} == *9999* ]]; then
		EGIT_BRANCH="$(usex binary release master)"
		git-r3_src_unpack
	elif use binary && use font_types_ttc; then
		cp "${DISTDIR}"/${A} "${WORKDIR}"
	else
		default
	fi
}

pkg_setup() {
	if use binary; then
		if [[ -n ${PV%%*9999} ]]; then
			S="${WORKDIR}"
			FONT_S=(
				${FONT_S[@]/#/${MY_PN}}
				.
			)
		else
			FONT_S=(
				${FONT_S[@]/#/SubsetOTF/}
				OTC
			)
			DOCS="*.pdf"
		fi
	fi
	font-r1_pkg_setup
}

src_compile() {
	use binary && return
	source "${S}"/COMMANDS.txt
}
