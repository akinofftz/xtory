#!/bin/sh
if [ -z "$1" ]; then
	echo Aufruf: $0 \<Story-ID\>
	exit 1
fi

xsltproc -o $1.svg xsl/cover.xsl xml/$1.xml
java -Xms32M -Xmx512M -cp fop/lib/batik-all-1.6.jar:fop/lib/xercesImpl-2.7.1.jar org.apache.batik.apps.rasterizer.Main -scriptSecurityOff $1.svg
[ -z "$2" ] && display $1.png
convert -resize 99x132 $1.png $1-thumb.jpg
convert $1.png $1.jpg
rm $1.png $1.svg

