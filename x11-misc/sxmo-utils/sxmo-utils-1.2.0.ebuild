# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Utility scripts, programs, and configs that hold the Sxmo UI environment together"
HOMEPAGE="https://git.sr.ht/~mil/sxmo-utils"
SRC_URI="https://git.sr.ht/~mil/sxmo-utils/archive/${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"

DEPEND="
	x11-misc/sxmo-dmenu
	x11-wm/sxmo-dwm
	x11-terms/sxmo-st
	www-client/sxmo-surf
	x11-misc/svkbd
	x11-misc/lisgd
	media-sound/alsa-utils
	x11-misc/autocutsel
	app-admin/conky
	sys-apps/coreutils
	net-misc/curl
	x11-misc/dunst
	media-video/ffmpeg
	sys-apps/gawk
	app-misc/geoclue
	sys-apps/grep
	sys-fs/inotify-tools
	media-video/mediainfo
	net-misc/modemmanager
	media-video/mpv
	sys-libs/ncurses
	net-misc/sfeed
	media-gfx/sxiv
	media-fonts/terminus-font
	sys-libs/timezone-data
	media-tv/v4l-utils
	app-editors/vis
	www-client/w3m
	x11-misc/xclip
	x11-misc/xdotool
	x11-apps/xdpyinfo
	x11-apps/xinput
	x11-apps/xprop
	x11-apps/xrandr
	x11-apps/xrdb
	x11-misc/xsel
	x11-apps/xset
	x11-apps/xsetroot
	x11-apps/xwininfo
	net-misc/youtube-dl
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default_src_prepare
	sed -i -e 's/shellcheck/true/' "${S}"/Makefile
}

src_install() {
	insinto "${EPREFIX}"/usr/share/${P}
	doins "${D}"/configs/*

	insinto "${EPREFIX}"/etc/alsa/conf.d
	doins "${D}"/configs/alsa/alsa_sxmo_enable_dmix.conf

	insinto "${EPREFIX}"/etc/polkit-1/rules.d
	doins "${D}"/configs/polkit/*.rules

	insinto "${EPREFIX}"/etc/udev/rules.d
	doins "${D}"/configs/udev/*.rules

	insinto "${EPREFIX}"/usr/share/applications
	doins "${D}"/configs/xdg/mimeapps.list

	dobin "${D}"/scripts/*/*

	dobin "${D}"/programs/sxmo_{setpineled,setpinebacklight,screenlock}
	dobin "${D}"/programs/sxmo_{megiaudioroute,vibratepine}

	insinto /etc/modprobe.d/
	doins "${FILESDIR}/sxmo.conf"

	fperms u+s "${D}/usr/bin/sxmo_{setpineled,setpinebacklight,screenlock}"
}
