# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="sxmo UI; supports highlight, centering, volume-key navigation and more"
SRC_URI="https://git.sr.ht/~mil/sxmo-dmenu/archive/${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXft
"

src_prepare() {
	default_src_prepare
	sed -i -e '/CFLAGS/{s/-Os//;s/=/+=/}' \
			-e '/LDFLAGS/{s/=/+=/}' \
					"${S}"/config.mk
}

src_install() {
	emake DESTDIR="${D}" PREFIX=${EPREFIX}/usr install
}
