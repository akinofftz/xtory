#!/bin/sh
if [ -z "$1" ]; then
	echo Aufruf: $0 \<Story-ID\>
	exit 1
fi

cp template.epub $1.epub

[ -e $1.jpg ] || ./cover.sh $1 -q
xsltproc -o xtory.opf xsl/epub-opf.xsl xml/$1.xml
xsltproc -o xtory.ncx xsl/epub-ncx.xsl xml/$1.xml
xsltproc -o imprint.xhtml xsl/epub-xhtml.xsl xml/$1.xml
zip $1.epub $1.jpg xtory.opf xtory.ncx *.xhtml && rm $1.jpg $1-thumb.jpg xtory.opf xtory.ncx *.xhtml
zip $1.epub gfx/$1?.jpg

