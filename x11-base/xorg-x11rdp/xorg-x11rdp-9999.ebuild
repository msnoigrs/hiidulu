# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: x11-base/xorg-x11rdp/xorg-x11rdp-9999.ebuild,v 1.1 2013/11/14 15:45:00 itspec.ru Exp $

EAPI="3"

inherit git-2 eutils

DESCRIPTION="xorg-x11rdp"
HOMEPAGE="http://www.xrdp.org/"

SRC_URI="http://www.x.org/releases/X11R7.6/src/everything/util-macros-1.11.0.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/xf86driproto-2.1.0.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/dri2proto-2.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/glproto-1.4.12.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libpciaccess-0.12.0.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libpthread-stubs-0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/damageproto-1.2.1.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/xextproto-7.1.2.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/xproto-7.0.20.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/xcb-proto-1.6.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libxcb-1.7.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/xtrans-1.2.6.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libX11-1.4.0.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libXext-1.2.0.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libICE-1.0.7.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libSM-1.2.0.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libXt-1.0.9.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libXdamage-1.1.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libXfixes-4.0.5.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/randrproto-1.3.2.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/renderproto-0.11.1.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/fixesproto-4.1.2.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/xcmiscproto-1.2.1.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/xf86vidmodeproto-2.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/xf86bigfontproto-1.2.0.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/scrnsaverproto-1.2.1.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/bigreqsproto-1.1.1.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/resourceproto-1.1.1.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/fontsproto-2.1.1.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/inputproto-2.0.1.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/xf86dgaproto-2.1.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/videoproto-2.3.1.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/compositeproto-0.4.2.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/recordproto-1.14.1.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/xineramaproto-1.2.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libXau-1.0.6.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/kbproto-1.0.5.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libXdmcp-1.1.0.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libxkbfile-1.0.7.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libfontenc-1.1.0.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libXfont-1.4.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libXmu-1.1.0.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libXxf86vm-1.1.1.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libXpm-3.5.9.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/libXaw-1.0.8.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/mkfontdir-1.0.6.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/mkfontscale-1.0.8.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/xkbcomp-1.2.0.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/xdriinfo-1.0.4.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/xorg-server-1.9.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/applewmproto-1.4.1.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/bdftopcf-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-adobe-75dpi-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-adobe-100dpi-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-adobe-utopia-75dpi-1.0.4.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-adobe-utopia-100dpi-1.0.4.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-adobe-utopia-type1-1.0.4.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-alias-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-arabic-misc-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-bh-75dpi-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-bh-100dpi-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-bh-lucidatypewriter-75dpi-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-bh-lucidatypewriter-100dpi-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-bh-ttf-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-bh-type1-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-bitstream-75dpi-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-bitstream-100dpi-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-bitstream-type1-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-cronyx-cyrillic-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-cursor-misc-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-daewoo-misc-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-dec-misc-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-ibm-type1-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-isas-misc-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-jis-misc-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-micro-misc-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-misc-cyrillic-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-misc-ethiopic-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-misc-meltho-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-misc-misc-1.1.2.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-mutt-misc-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-schumacher-misc-1.1.2.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-screen-cyrillic-1.0.4.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-sony-misc-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-sun-misc-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-util-1.2.0.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-winitzki-cyrillic-1.0.3.tar.bz2
http://www.x.org/releases/X11R7.6/src/everything/font-xfree86-type1-1.0.4.tar.bz2
http://www.python.org/ftp/python/2.7/Python-2.7.tar.bz2
http://dri.freedesktop.org/libdrm/libdrm-2.4.26.tar.bz2
http://xorg.freedesktop.org/releases/individual/util/makedepend-1.0.3.tar.bz2
ftp://ftp.xmlsoft.org/libxml2/libxml2-sources-2.7.8.tar.gz
http://server1.xrdp.org/xrdp/libpng-1.2.46.tar.gz
http://ftp.x.org/pub/individual/lib/pixman-0.30.0.tar.bz2
http://download.savannah.gnu.org/releases/freetype/freetype-2.4.6.tar.bz2
http://server1.xrdp.org/xrdp/fontconfig-2.8.0.tar.gz
http://server1.xrdp.org/xrdp/cairo-1.8.8.tar.gz
http://server1.xrdp.org/xrdp/expat-2.0.1.tar.gz
ftp://ftp.freedesktop.org/pub/mesa/7.10.3/MesaLib-7.10.3.tar.bz2
ftp://xmlsoft.org/libxslt/libxslt-1.1.26.tar.gz
http://launchpad.net/intltool/trunk/0.41.1/+download/intltool-0.41.1.tar.gz
http://www.x.org/releases/individual/data/xkeyboard-config/xkeyboard-config-2.0.tar.bz2"

EGIT_REPO_URI="git://github.com/FreeRDP/xrdp.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

export X11RDPBASE="${EPREFIX}/usr/${PN}"
export PKG_CONFIG_PATH="${D}/${X11RDPBASE}/lib/pkgconfig/:${D}/${X11RDPBASE}/share/pkgconfig/"
export PKG_CONFIG_SYSROOT_DIR="${D}"
export PATH="${D}/${X11RDPBASE}/bin:${PATH}"
export LDFLAGS="-Wl,-rpath=${X11RDPBASE}/lib"
export CFLAGS="-I${X11RDPBASE}/include -I${D}/${X11RDPBASE}/include -I${D}/${X11RDPBASE}/include/python2.7 -I${D}/${X11RDPBASE}/include/pixman-1 -I${D}/${X11RDPBASE}/include/libpng12 -I${D}/${X11RDPBASE}/include/cairo -I${D}/${X11RDPBASE}/include/freetype2 -I${D}/${X11RDPBASE}/include/libdrm -I${D}/${X11RDPBASE}/include/libkms -I${D}/${X11RDPBASE}/include/libxml2 -L${D}/${X11RDPBASE}/lib -fPIC -O2"

src_unpack() {
	EGIT_NOUNPACK="1"
	git-2_src_unpack
	S=${WORKDIR}/${P}/xorg/X11R7.6
	data_file=${S}/x11_file_list.txt
	num_modules=`cat $data_file | wc -l`

	mkdir ${S}/build_dir
	cd ${S}/build_dir

	count=0

	while read line
	do
		mod_file=`echo $line | cut -d':' -f1`

		count=`expr $count + 1`

		einfo "($count of $num_modules)"

		unpack $mod_file || die "unpack $mod_file failed"

	done < $data_file
}

src_prepare() {
	epatch ${FILESDIR}/x11_file_list.patch || die "epatch x11_file_list.patch failed"

	while read line
	do
		mod_name=`echo $line | cut -d':' -f2`
		mod_name=`eval echo $mod_name`
		if [ -e ${S}/"${mod_name}".patch ]; then
			cd ${S}/build_dir/"$mod_name"
			epatch ${S}/"$mod_name".patch || die "epatch $mod_name failed"
		fi
	done < $data_file
}

src_compile() {
	count=0

	while read line
	do
		mod_name=`echo $line | cut -d':' -f2`
		mod_name=`eval echo $mod_name`
		mod_args=`echo $line | cut -d':' -f3`
		mod_args=`eval echo $mod_args`

		count=`expr $count + 1`

		einfo ""
		einfo "*** processing module $mod_name ($count of $num_modules) ***"
		einfo ""

		cd ${S}/build_dir/"$mod_name"

		econf --datadir="${X11RDPBASE}/share" \
			  --infodir="${X11RDPBASE}/share/info" \
			  --prefix="${X11RDPBASE}" \
			  --mandir="${X11RDPBASE}/share/man" \
			  --sysconfdir="${X11RDPBASE}/etc" \
			 ${mod_args} \
		|| die "configure $mod_name failed"

		emake -j1 || die "compile $mod_name failed"
		emake -j1 install DESTDIR="${D}"  || die "install $mod_name failed"

		# special case after installing python make this sym link
		# so Mesa builds using this python version
		case "$mod_name" in
		  *Python-2*)
		  (dosym ${X11RDPBASE}/bin/python ${X11RDPBASE}/bin/python2) || die "can not create symlink to python"
		  ;;
		esac

	done < $data_file

	cd ${S}/rdp
	emake -j1 || die "compile rdp failed"
}

src_install() {
	cd ${S}/rdp
	cp X11rdp ${D}/usr/${PN}/bin/
	dosym /usr/${PN}/bin/X11rdp /usr/bin/X11rdp
}

pkg_postinst() {
	elog
	elog "For testing X11rdp run"
	elog "\`X11rdp :10\`"
	elog
}
