# CD Ripper

A docker container that, when run, spits out your cd tray so you can place an audio cd in.
It will then rip the cd, placing the output files in a volume. After the rip it will spit out
the cd tray and expect you to add another audio cd to repeat the process.

## Docker

### Build

To build the container, nothing special, just this:

    $ docker build -t cdripper .

### Run

I would expect the best way to run this is in an terminal so you can monitor the output, do so like so:

    $ docker run -it --rm --privileged -v `pwd`/rips:/output --device=/dev/sr0:/dev/sr0 cdripper

NOTE: I neede --privileged so that the cd would eject

