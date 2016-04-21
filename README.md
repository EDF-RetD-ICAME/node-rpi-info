RPI Version
===========

Rpis Versions are taken from :

    * http://www.raspberrypi-spy.co.uk/2012/09/checking-your-raspberry-pi-board-version/
    * http://elinux.org/RPi_HardwareHistory

Installation
------------

```rpi-version``` can be installed globally and used at command line or programmatically.

```
[sudo] npm install [-g] rpi-version
```

Usage
-----
```
Usage: rpi-version [options] [command]

Commands:

  field|f <field>  [version, model, releaseDate, revisions]
  after|a <date>   Check if this raspberry pi is released after the given date
  before|b <date>  Check if this raspberry pi is released before the given date
  unknown|u        Check if this raspberry pi has a recognized hardware revision
  all              Show all available infos for this raspberry pi

Options:

  -h, --help              output usage information
  -V, --version           output the version number
  -r, --revision [value]  Revision
  -s, --silent            Display raw information only
```

By default :
```
rpi-version
```

render something like :
```
RaspberryPi 3 Model B released Q1 2016
Revision : 'a02082'
All revisions availables for this kind of device : [ 'a02082', 'a22082' ]
```

Programmatically
----------------

```javascript
var RPI = require('rpi-version');
var rpi = new RPI(revision); // revision is optionnal - if not present, /proc/cpuinfo is parsed

rpi.getRevision();

rpi.getVersions();

rpi.getField(name);

rpi.getVersion();

rpi.getModel();

rpi.getReleaseDate();

rpi.getAllRevisions();

rpi.isReleasedBefore(date);

rpi.isReleasedAfter(date)

rpi.isUnknown();

rpi.getInfos();
```
