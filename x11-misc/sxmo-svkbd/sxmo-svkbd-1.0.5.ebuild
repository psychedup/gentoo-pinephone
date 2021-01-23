# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="svkbd - Suckless keyboard input"
HOMEPAGE="https://tools.suckless.org/svkbd"
SRC_URI="https://git.sr.ht/~mil/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT/X"
SLOT="0"
KEYWORDS="~arm64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	x11-libs/libXtst
	x11-libs/libXft
	x11-libs/libXinerama
"

src_prepare() {
	default_src_prepare
	sed -i -e '/CFLAGS/{s/-Os//;s/=/+=/}' \
		-e '/LDFLAGS/{s/=/+=/}' \
		"${S}"/config.mk
}

src_compile() {
	emake svkbd-sxmo
}

src_install() {
	emake LAYOUT=sxmo PREFIX="${D}"/usr install
}
