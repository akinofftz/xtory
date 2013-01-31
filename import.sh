#!/bin/sh

usage() {
	echo Xtory-Dokumentenimporter.
	echo ""
	echo Aufruf:
	echo   $0 \<Story-ID\>
	exit 1
}

[ -z "$1" ] && usage

FILE=$1.odt

jar xf $1.odt content.xml
xsltproc --stringparam id $1 -o xml/$1.xml xsl/odtimport.xsl content.xml
rm content.xml
gvim xml/$1.xml

