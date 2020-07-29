FROM debian

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_BASE_PACKAGES abcde cdparanoia flac imagemagick glyrc lame git cd-discid id3 opus-tools \
      id3v2 libmusicbrainz-discid-perl libwebservice-musicbrainz-perl eyed3 eject setcd
RUN apt-get update && apt-get upgrade --assume-yes && apt-get dist-upgrade --assume-yes \
    && apt-get install --assume-yes $DEBIAN_BASE_PACKAGES \
    && apt-get --assume-yes autoremove && apt-get --assume-yes autoclean && apt-get --assume-yes clean \
    && cpan install Mojo::DOM

RUN mkdir /opt/app
WORKDIR /opt/app
ADD init.sh abcde.conf munger.py /opt/app/
RUN chmod +x init.sh munger.py
CMD /opt/app/init.sh
