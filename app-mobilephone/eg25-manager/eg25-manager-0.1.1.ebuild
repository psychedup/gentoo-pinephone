# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Daemon for managing the Quectel EG25 modem"
HOMEPAGE="https://gitlab.com/mobian1/devices/eg25-manager"
SRC_URI="https://gitlab.com/mobian1/devices/eg25-manager/-/archive/${PV}/eg25-manager-${PV}.tar.gz"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~arm64"

DEPEND="sys-libs/glibc
		dev-libs/libgpiod
		dev-libs/libgudev
		virtual/libusb
		dev-util/meson
		net-misc/modemmanager
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install

	newinitd "${FILESDIR}/eg25-manager.initd" eg25-manager
	newconfd "${FILESDIR}/eg25-manager.confd" eg25-manager
}
