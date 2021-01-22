# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Surf fork for Sxmo UI; supports externalpipe, keyword searching, non-JS by default"
HOMEPAGE="https://git.sr.ht/~mil/sxmo-surf"
SRC_URI="https://git.sr.ht/~mil/sxmo-surf/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"

DEPEND="
	x11-apps/xprop
	dev-libs/libxml2
	x11-misc/sxmo-dmenu
"
RDEPEND="${DEPEND}"
BDEPEND="
	net-libs/webkit-gtk
"

src_prepare() {
	default_src_prepare
	sed -i -e '/CFLAGS/{s/-Os//;s/=/+=/}' \
			-e '/LDFLAGS/{s/-s//;s/=/+=/}' \
			"${S}"/config.mk
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install

	dodoc README TODO.md
}
