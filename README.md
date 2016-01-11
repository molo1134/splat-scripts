# splat-scripts

Scripts to run the [Splat!](http://www.qsl.net/kd2bd/splat.html) radio terrain
mapping tool.

## Dependencies

This was built and tested on Debian Jessie (8.0) with the following versions:

```
ii  imagemagick    8:6.8.9.9-5  amd64        image manipulation programs -- bi
ii  optipng        0.7.5-1      amd64        advanced PNG (Portable Network Gr
ii  splat          1.4.0-2      amd64        analyze point-to-point terrestria
ii  wget           1.16-1       amd64        retrieves files from the web
```

## Configuration

Edit the shell scripts to set the paths for the SDF elevation files and the
political borders file.

To download and convert the SRTM data use the `get-datafiles*.sh` scripts. Go
get some coffee while this runs, it will take a while. After it is completed,
you should be able to run the example profile as below.

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

## Output

![output map thumbnail](example-map-thumb.jpg)

[Full resolution here](example-map.png)

[Height above average terrain, in feet](example-haat.txt)

