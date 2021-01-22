# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Experimental (cli, web, and gopher) frontends for youtube, reddit, & duckduckgo"
HOMEPAGE="https://www.codemadness.org/idiotbox.html"
SRC_URI="https://codemadness.org/releases/frontends/frontends-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/libretls
	dev-libs/libressl
"

S=${WORKDIR}/frontends-${PV}
src_prepare() {
	sed -i 's/^#FRONTENDS_/FRONTENDS_/g' Makefile
	sed -i 's/^#LIBTLS_/LIBTLS_/g' Makefile
	default_src_prepare
}

src_install() {
	newbin youtube/cgi youtube-cgi
	newbin youtube/gopher youtube-gopher
	newbin youtube/cli youtube-cli

	newbin duckduckgo/gopher duckduckgo-gopher
	newbin duckduckgo/cli duckduckgo-cli

	newbin reddit/gopher reddit-gopher
	newbin reddit/cli reddit-cli
}
