#!/bin/sh

# get the SRTM data files and convert them for splat use

# License: Public domain / CC-0

# Takes one parameter: the continent to retrieve.  Valid values:
#
# Africa
# Australia
# Eurasia
# Islands
# North_America
# South_America

# path to topgraphy datafiles
TOPOFILEDIR=splat-datafiles/sdf/
# local hgt file archive
HGTFILEDIR=splat-datafiles/hgtzip/

CONTINENT=$1
case $CONTINENT in
	North_America|South_America|Africa|Eurasia|Australia|Islands)
		echo $CONTINENT
		;;
	*)
		echo "Invalid continent: $CONTINENT"
		exit 1
		;;
esac


INDEXURL="http://dds.cr.usgs.gov/srtm/version2_1/SRTM3/${CONTINENT}/"

INDEXFILE=`mktemp`

if [ ! -x `which srtm2sdf` ]; then
	echo "error: not found in path: srtm2sdf splat conversion utility"
	exit 1
fi

if [ ! -x `which readlink` ]; then
	echo "error: not found in path: readlink"
	exit 1
fi

if [ ! -x `which wget` ]; then
	echo "error: not found in path: wget"
	exit 1
fi

if [ ! -x `which unzip` ]; then
	echo "error: not found in path: unzip"
	exit 1
fi

if [ ! -x `which bzip2` ]; then
	echo "error: not found in path: bzip2"
	exit 1
fi

echo "getting index.."
wget -q -O - $INDEXURL | \
	sed -r -e '/hgt.zip/!d; s/.* ([NSWE0-9]+\.?hgt\.zip).*$/\1/;' \
	> $INDEXFILE

mkdir -p $HGTFILEDIR
mkdir -p $TOPOFILEDIR

echo "retrieving files.."
cd $HGTFILEDIR
wget -nv -N -B $INDEXURL -i $INDEXFILE
cd -

rm $INDEXFILE

# to minimize disk space required, run srtm2sdf on each file as it is unzipped.

HGTREALPATH=`readlink -f $HGTFILEDIR`
TOPOREALPATH=`readlink -f $TOPOFILEDIR`
PWD=`pwd`

echo "unpacking hgt files.."
cd $HGTFILEDIR
for e in *.zip ; do 
	echo $e
	nice unzip -o $e
	HGTFILE=`echo $e | sed -r -e 's/\.?hgt.zip/.hgt/'`
	if [ -r $HGTFILE ]; then
		cd $TOPOREALPATH
		nice srtm2sdf -d /dev/null $HGTREALPATH/$HGTFILE
		echo "compressing.."
		nice bzip2 -f -- *.sdf
		echo "deleting hgt file.."
		cd $HGTREALPATH
		rm $HGTFILE
	fi
done

cd $PWD

echo "Complete.  The files in $HGTFILEDIR may be removed."


