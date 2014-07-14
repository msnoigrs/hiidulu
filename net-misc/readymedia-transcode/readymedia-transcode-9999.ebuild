# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://bitbucket.org/stativ/readymedia-transcode.git"
EGIT_BRANCH="transcode"

inherit git-2 autotools eutils systemd toolchain-funcs user

MY_PN="minidlna"

DESCRIPTION="a personal development branch of ReadyMedia"
HOMEPAGE="https://bitbucket.org/stativ/readymedia-transcode"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="netgear readynas"

RDEPEND="!net-misc/minidlna
	dev-db/sqlite
	media-libs/flac
	media-libs/libexif
	media-libs/libid3tag
	media-libs/libogg
	media-libs/libvorbis
	virtual/ffmpeg
	virtual/jpeg
	media-gfx/imagemagick"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	local my_is_new="yes"
	[ -d "${EPREFIX}"/var/lib/${PN} ] && my_is_new="no"
	enewgroup ${MY_PN}
	enewuser ${MY_PN} -1 -1 /var/lib/${MY_PN} ${MY_PN}
	if [ -d "${EPREFIX}"/var/lib/${MY_PN} ] && [ "${my_is_new}" == "yes" ] ; then
		# created by above enewuser command w/ wrong group and permissions
		chown ${MY_PN}:${MY_PN} "${EPREFIX}"/var/lib/${MY_PN} || die
		chmod 0750 "${EPREFIX}"/var/lib/${MY_PN} || die
		# if user already exists, but /var/lib/minidlna is missing
		# rely on ${D}/var/lib/minidlna created in src_install
	fi
}

src_prepare() {
	sed -e "/log_dir/s:/var/log:/var/log/${MY_PN}:" \
		-e "/db_dir/s:/var/cache/:/var/lib/:" \
		-i ${MY_PN}.conf || die

	sed -e 's|transcode_audio_transcoder=.*|transcode_audio_transcoder=/usr/share/minidlna/transcodescripts/transcode_audio|' \
		-e 's|transcode_video_transcoder=.*|transcode_video_transcoder=/usr/share/minidlna/transcodescripts/transcode_video|' \
		-e 's|transcode_image_transcoder=.*|transcode_image_transcoder=/usr/share/minidlna/transcodescripts/transcode_image|' \
		-i ${MY_PN}.conf || die

	sed -e 's/pal-dvd/ntsc-dvd/' -i transcodescripts/transcode_video

	epatch_user

	eautoreconf
}

src_configure() {
	econf \
		--disable-silent-rules \
		--with-db-path=/var/lib/${MY_PN} \
		--with-log-path=/var/log/${MY_PN} \
		--enable-tivo \
		$(use_enable netgear) \
		$(use_enable readynas)
}

src_install() {
	default

	insinto /etc
	doins ${MY_PN}.conf

	newconfd "${FILESDIR}"/${MY_PN}.confd ${MY_PN}
	newinitd "${FILESDIR}"/${MY_PN}.initd ${MY_PN}
	systemd_newunit "${FILESDIR}"/${MY_PN}.service ${MY_PN}.service
	echo "d /run/${MY_PN} 0755 ${MY_PN} ${MY_PN} -" > "${T}"/${MY_PN}.conf
	systemd_dotmpfilesd "${T}"/${MY_PN}.conf

	dodir /var/{lib,log}/${MY_PN}
	dodir /run/${MY_PN}
	fowners ${MY_PN}:${MY_PN} /var/{lib,log}/${MY_PN}
	fowners ${MY_PN}:${MY_PN} /run/${MY_PN}
	fperms 0750 /var/{lib,log}/${MY_PN}

	dodoc AUTHORS NEWS README TODO
	doman ${MY_PN}d.8 ${MY_PN}.conf.5
}

pkg_postinst() {
	elog "minidlna now runs as minidlna:minidlna (bug 426726),"
	elog "logfile is moved to /var/log/minidlna/minidlna.log,"
	elog "cache is moved to /var/lib/minidlna."
	elog "Please edit /etc/conf.d/${MY_PN} and file ownerships to suit your needs."
}
