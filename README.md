# CD Ripper

A docker container that, when run, spits out your cd tray so you can place an audio cd in.
It will then rip the cd, placing the output files in a volume. After the rip it will spit out
the cd tray and expect you to add another audio cd to repeat the process.

## Docker

Available at dockerhub here: https://hub.docker.com/r/bugthing/cdripper

### Build

To build the container, nothing special, just this:

    $ docker build -t cdripper .

### Run

I would expect the best way to run this is in an terminal so you can monitor the output, do so like this:

    $ docker run -it --rm --privileged -v `pwd`/rips:/output --device=/dev/sr0:/dev/sr0 cdripper

NOTE: I needed --privileged so that the cd would eject
You will see above I have mounted a volume (-v) and attached a device (--device).
The volume mounted at /output is where the CD audio (mp3 files) will be written to.
The device mounted at /dev/sr0 is the scsi cd device from my linux machine.

