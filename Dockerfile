# Dockerfile for TheDarkMod
#
# Linux kabah 4.4.0-96-generic #119~14.04.1-Ubuntu SMP Wed Sep 13 08:40:48 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
# Docker version 17.05.0-ce, build 89658be
#
# docker build -t tdm .
# xhost +
# docker run -ti --rm --net=host --privileged=true -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 -v /dev/snd:/dev/snd -v /home/paul:/home/paul tdm

FROM m0elnx/ubuntu-32bit

RUN	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends alsa-utils && \
	apt-get install -y --no-install-recommends xorg && \
	apt-get install -y --no-install-recommends nvidia-340 && \
#	apt-get install -y --no-install-recommends mesa-utils && \
	apt-get autoremove -y --purge && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd -g 1000 paul
RUN useradd -u 1000 -g paul -d /home/paul -s /bin/bash paul

ENV DISPLAY :0.0

USER paul
WORKDIR /home/paul/TheDarkMod
CMD /home/paul/TheDarkMod/thedarkmod.x86 +set s_alsa_pcm default:CARD=AUDIO

