# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="RSS and Atom feed fetcher"
HOMEPAGE="https://www.codemadness.org/sfeed.html"
SRC_URI="https://codemadness.org/releases/sfeed/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~arm64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	emake MANPREFIX="${EPREFIX}"/usr/share/man DOCPREFIX="${EPREFIX}"/usr/share/doc/"${P}" PREFIX="${EPREFIX}"/usr DESTDIR="${D}" install
}
