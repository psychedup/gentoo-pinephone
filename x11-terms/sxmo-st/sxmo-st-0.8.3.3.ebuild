# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="St fork for Sxmo UI; supports scrollback, invert, and other patches"
HOMEPAGE="https://git.sr.ht/~mil/sxmo-st"
SRC_URI="https://git.sr.ht/~mil/sxmo-st/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"
BDEPEND="
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
"

src_prepare() {
	default_src_prepare
	sed -i '/tic/d' ${S}/Makefile
}

src_install() {
	emake PREFIX=${EPREFIX}/usr DESTDIR=${D}

	insinto /usr/share/applications/
	doins "${FILESDIR}/st.desktop"
}
