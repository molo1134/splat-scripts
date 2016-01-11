# splat-scripts

Scripts to run the [Splat!](http://www.qsl.net/kd2bd/splat.html) radio terrain
mapping tool.

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

Output:

![output map](example-map-thumb.jpg)

[Full resolution here](example-map.png)


