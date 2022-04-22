# woposs

[![License][license-img]][license-url]
[![GitHub release][release-img]][release-url]


<img src="icon.png" align="left" width="25%"/>

Application for the project A World of Possibilities

## Requirements

*   [exist-db](http://exist-db.org/exist/apps/homepage/index.html) version: `5.x` or greater

*   [ant](http://ant.apache.org) version: `1.10.7` \(for building from source\)

*   [node](http://nodejs.org) version: `12.x` \(for building from source\)
    

## Installation

1.  Download  the `woposs-1.0.0.xar` file from GitHub [releases](https://github.com/helenasabel/woposs/releases) page.

2.  Open the [dashboard](http://localhost:8080/exist/apps/dashboard/index.html) of your eXist-db instance and click on `package manager`.

    1.  Click on the `add package` symbol in the upper left corner and select the `.xar` file you just downloaded.

3.  You have successfully installed woposs into exist.

### Building from source

1.  Download, fork or clone this GitHub repository
2.  There are two default build targets in `build.xml`:
    *   `dev` including *all* files from the source folder including those with potentially sensitive information.
  
    *   `deploy` is the official release. It excludes files necessary for development but that have no effect upon deployment.
  
3.  Calling `ant`in your CLI will build both files:
  
```bash
cd woposs
ant
```

   1. to only build a specific target call either `dev` or `deploy` like this:
   ```bash   
   ant dev
   ```   

If you see `BUILD SUCCESSFUL` ant has generated a `woposs-1.0.0.xar` file in the `build/` folder. To install it, follow the instructions [above](#installation).



## License

GPL-3.0 © [A World of Possibilities. Modal pathways over an extra-long period of time: the diachrony of modality in the Latin language](https://www.woposs.unine.ch/)

[license-img]: https://img.shields.io/badge/license-GPL%20v3-blue.svg
[license-url]: https://www.gnu.org/licenses/gpl-3.0
[release-img]: https://img.shields.io/badge/release-1.0.0-green.svg
[release-url]: https://github.com/helenasabel/woposs/releases/latest
