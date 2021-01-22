# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="simple libinput gesture daemon"
HOMEPAGE="http://git.sr.ht/~mil/lisgd"
SRC_URI="https://git.sr.ht/~mil/lisgd/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/libinput
	sys-fs/eudev
	x11-libs/libX11
"

src_install() {
	emake PREFIX="${EPREFIX}"/usr DESTDIR="${D}" install
}
