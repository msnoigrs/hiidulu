# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

EGIT_REPO_URI="https://github.com/rustsec/rustsec"

DESCRIPTION=""
HOMEPAGE="https://github.com/rustsec/rustsec/cargo-audit"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	virtual/rust
"

S="${WORKDIR}/${P}/${PN}"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack

	cd

	local myproxy
	if [[ -n "${http_proxy}" ]]; then
	   myproxy="${http_proxy}"
	elif [[ -n "${HTTP_PROXY}" ]]; then
	   myproxy="${HTTP_PROXY}"
	fi
	if [[ -n $myproxy ]]; then
		cat >> "${ECARGO_HOME}/config" <<- _EOF_ || "Failed to set proxy settings"
		[http]
		proxy = "${myproxy}"
		check-revoke = false
		_EOF_
	fi
}
