# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev

DESCRIPTION="PinePhone device packages and tweak scripts stolen from Manjanro"
HOMEPAGE="https://gitlab.manjaro.org/manjaro-arm/packages/community/phosh/pinephone-manjaro-tweaks.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"
IUSE=""

# todo: re-add USB tethering
DEPEND="media-libs/alsa-ucm-pinephone
		gnome-extra/iio-sensor-proxy
		x11-themes/sound-theme-librem5
		sys-firmware/anx7688-firmware
		sys-firmware/rtl8723bt-firmware
		sys-firmware/ov5640-firmware
		media-tv/v4l-utils
		app-mobilephone/pinephone-modem-scripts
		sys-boot/osk-sdl
"

RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_install() {
	udev_dorules "${FILESDIR}/10-proximity.rules"
	udev_dorules "${FILESDIR}/20-pinephone-led.rules"
	udev_dorules "${FILESDIR}/90-usb-gadget-managed.rules"
	udev_dorules "${FILESDIR}/99-automount-sd.rules"

	insinto /etc/gtk-3.0/
	doins "${FILESDIR}/gtk3-settings.ini"

	insinto /var/lib/polkit-1/localauthority/10-vendor.d
	doins "${FILESDIR}/org.freedesktop.ModemManager1.pkla"

}
