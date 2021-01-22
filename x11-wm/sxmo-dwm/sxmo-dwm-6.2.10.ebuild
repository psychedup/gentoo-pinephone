# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Dwm fork for Sxmo UI; supports volume-key hotkeys, swallow, keyboard, among other patches"
HOMEPAGE="https://git.sr.ht/~mil/sxmo-dwm"
SRC_URI="https://git.sr.ht/~mil/sxmo-dwm/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~arm64"

DEPEND="x11-base/xorg-server"
RDEPEND="${DEPEND}"
BDEPEND="
	x11-libs/libXft
	x11-libs/libX11
	x11-libs/libXinerama
"

src_prepare() {
	default_src_prepare
	sed -i -e '/CFLAGS/{s/-Os//;s/=/+=/}' \
			-e '/LDFLAGS/{s/=/+=/}' \
					"${S}"/config.mk
}

src_install() {
	emake PREFIX=${EPREFIX}/usr DESTDIR="${D}" install
}
