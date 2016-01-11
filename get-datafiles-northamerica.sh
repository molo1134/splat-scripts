#!/bin/sh

# get the SRTM data files and convert them for splat use
# requires ~11 GB free disk space
# results in ~3.6 GB disk space consumed

# path to topgraphy datafiles
TOPOFILEDIR=splat-datafiles/sdf/
# local hgt file archive
HGTFILEDIR=splat-datafiles/hgtzip/
# for state/county borders
BORDERDIR=splat-datafiles/borders/

BORDERURL="https://web.archive.org/web/20130331144934/http://www.census.gov/geo/cob/bdy/co/co00ascii/co99_d00_ascii.zip"

mkdir -p $BORDERDIR
cd $BORDERDIR
wget -N -nv $BORDERURL
unzip -o *.zip
cd -

INDEXURL="http://dds.cr.usgs.gov/srtm/version2_1/SRTM3/North_America/"

INDEXFILE=`mktemp`

echo "getting index.."
wget -q -O - $INDEXURL | \
	sed -e '/hgt.zip/!d; s/.* \([NSWE0-9]\+\.\?hgt\.zip\).*$/\1/;' \
	> $INDEXFILE

mkdir -p $HGTFILEDIR
mkdir -p $TOPOFILEDIR

cd $HGTFILEDIR
wget -nv -N -B $INDEXURL -i $INDEXFILE
cd -


# TODO: to minimize disk space required, run srtm2sdf on each file as it is
# unzipped.

echo "unpacking hgt files.."
cd $HGTFILEDIR
for e in *.zip ; do 
	echo $e
	unzip -o $e
done
cd -

echo "converting hgt files to sdf.."
HGTREALPATH=`realpath $HGTFILEDIR`
cd $TOPOFILEDIR
for e in $HGTREALPATH/*.hgt ; do
	srtm2sdf -d /dev/null $e
	echo "compressing.."
	nice bzip2 -f *.sdf
	echo "deleting hgt file.."
	rm $e
done

echo "Complete.  The files in $HGTFILEDIR may be removed."

