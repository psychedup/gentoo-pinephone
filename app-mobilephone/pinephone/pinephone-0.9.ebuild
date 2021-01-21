# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev

DESCRIPTION="PinePhone device packages and tweak scripts stolen from PostmarketOS"
HOMEPAGE="https://gitlab.com/postmarketOS/pmaports/-/blob/master/device/main/device-pine64-pinephone/APKBUILD"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"
IUSE=""

DEPEND="sys-fs/udev
		media-libs/alsa-ucm-conf
		net-dialup/atinout
		app-mobilephone/eg25-manager[openrc]
		sci-geosciences/gpsd
		net-wireless/iw
		media-libs/mesa[dri3,egl,gallium]
		sys-firmware/anx7688-firmware
		sys-firmware/rtl8723bt-firmware
		sys-firmware/ov5640-firmware
"

RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_install() {

	insinto /usr/share/
	doins "${FILESDIR}/hwtest.ini"

	# GPS
	newinitd "${FILESDIR}/gpsd_pinephone.initd" gpsd_pinephone
	exeinto /etc/gps/
	newexe "${FILESDIR}/gpsd_device-hook.sh" device-hook
	udev_dorules "${FILESDIR}/10-pinephone-proximity.rules"

	# fix sysrq: HELP messages while playing audio
	insinto /etc/sysctl.d/
	doins "${FILESDIR}/sysrq.conf"

	# alsa default stereo
	insinto /etc/
	doins "${FILESDIR}/asound.conf"

	# Alsa use case manager config
	insinto /usr/share/alsa/ucm2/PinePhone/
	doins "${FILESDIR}/ucm/PinePhone.conf"
	doins "${FILESDIR}/ucm/HiFi.conf"
	doins "${FILESDIR}/ucm/VoiceCall.conf"

	# Modem
	newbin "${FILESDIR}/setup-modem.sh" pinephone_setup-modem
	udev_dorules "${FILESDIR}/90-modem-eg25.rules"

	# Wifi/PM
	udev_dorules "${FILESDIR}/70-wifi-pm.rules"

}

