# splat-scripts

Scripts to run the [Splat!](http://www.qsl.net/kd2bd/splat.html) radio terrain
mapping tool.

## Configuration

Edit `splat-radio.sh` and set the paths for the SDF elevation files and the
political borders file.

Download the SRTM data for your location.  Convert that data to SDF elevation
data.

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

Output:

![output map](example-map-thumb.jpg)

[Full resolution here](example-map.png)
