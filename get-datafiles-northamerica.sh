#!/bin/sh

# get the SRTM data files and convert them for splat use
# results in ~3.6 GB disk space consumed

# for state/county borders
BORDERDIR=splat-datafiles/borders/

BORDERURL="https://web.archive.org/web/20130331144934/http://www.census.gov/geo/cob/bdy/co/co00ascii/co99_d00_ascii.zip"

mkdir -p $BORDERDIR
cd $BORDERDIR
echo "retrieving state/county borders.."
wget -N -nv $BORDERURL
echo "unpacking state/county borders.."
unzip -o *.zip
cd -

./get-datafiles.sh "North_America"

