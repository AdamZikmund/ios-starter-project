#!/bin/sh

fonts=$1/static/font
info=$1/Info.plist

plutil -replace UIAppFonts -xml '<array/>' $info
find $fonts -type f ! -name '.DS_Store' -exec basename {} \; | while read line; do
    plutil -replace UIAppFonts.0 -string "$line" $info
done
