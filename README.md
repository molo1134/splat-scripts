# splat-scripts

Scripts to run the [Splat!](http://www.qsl.net/kd2bd/splat.html) radio terrain
mapping tool.

## Dependencies

This was built and tested on Debian Jessie (8.0) with the following versions:

```
ii  splat          1.4.0-2       amd64        analyze point-to-point terrestria
ii  coreutils      8.23-4        amd64        GNU core utilities
ii  imagemagick    8:6.8.9.9-5   amd64        image manipulation programs -- bi
ii  optipng        0.7.5-1       amd64        advanced PNG (Portable Network Gr
ii  sed            4.2.2-4+b1    amd64        The GNU sed stream editor
ii  wget           1.16-1        amd64        retrieves files from the web
ii  unzip          6.0-16+deb8u2 amd64        De-archiver for .zip files
```

Success was also reported on Ubuntu, FreeBSD, and OpenBSD.

## Configuration

Edit the shell scripts to set the paths for the SDF elevation files and the
political borders file.

To download and convert the SRTM data use the `get-datafiles*.sh` scripts. Go
get some coffee while this runs, it will take a while. After it is completed,
you should be able to run the example profile as below.

If interrupted, the retrieval of the SRTM `*hgt.zip` files over the network can
be restarted and will resume where it left off.

Note the following disk space requirements to complete the data conversion:

* Africa: 5.4 GB
* Australia: 1.2 GB
* Eurasia: 9.0 GB
* Islands: 92 MB
* North America: 3.6 GB
* South America: 3.3 GB
* All: 23 GB

The `*hgt.zip` files are not required after conversion, but they are not
removed by the script.  They are retained so that a new run may commence
without downloading all the files again from the server.  This happens via the
`wget` `-N` option.

After removing the `*hgt.zip` files, disk space required for operations comes
down to:

* Africa: 2.1 GB
* Australia: 434 MB
* Eurasia 3.4 GB
* Islands: 36 MB
* North America: 1.4 GB
* South America: 1.3 GB
* All: 8.5 GB

## Usage

```
$ ./splat-radio.sh example.cfg
```

```
$ cat example.cfg
NAME="example"
CALL="KQ2H"
LAT="40.7484931946"
LON="-73.9856567383"
HTAGL="373m"
ERP="250"
FREQMHZ="449.2250"
```

Parameters are as follows:

* `NAME`: used to uniquely name files
* `CALL`: will be labeled onto the map
* `LAT`: latitude, decimal degrees
* `LON`: longitude, decimal degrees (East is positive)
* `HTAGL`: height above ground level -- without units the default is in feet;
  use a "m" suffix for meters (e.g. "30" means 30 feet; "10m" means 10 meters)
* `ERP`: effective radiated power in Watts -- be sure you take feedline loss
  and antenna gain into account; enter ERP="0" to produce path loss plots
* `FREQMHZ`: frequency in MHz

## Output

![output map thumbnail](example-map-thumb.jpg)

[Full resolution here](example-map.png)

[Height above average terrain, in feet](example-haat.txt)

## Prediction and propagation notes

These predictions are configured to estimate a *simplex* contact, with a
**receiver station at 2 meters (6 feet)**, similar to a mobile station.  This
is not a valid prediction for access to repeater stations on towers.  This of
course can be changed by editing the `splat-radio.sh` script.

The model does not take reflections and multipath into account.

Defaults were chosen for things like ground permeativity and other parameters.
Adjust as needed if your situation warrants it.

## To do

* More error checking.

