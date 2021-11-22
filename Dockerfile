FROM nvidia/cuda:11.2.2-base

ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

# ENV WALLET=0xe3da8F76549450c737D4aee86036d59CbFfe46fa
ENV SERVER=stratum+ssl://us1.ethermine.org:5555
ENV WORKER=Rig
ENV ALGO=ethash

ENV TREX_URL="https://github.com/trexminer/T-Rex/releases/download/0.20.3/t-rex-0.20.3-linux.tar.gz"

ADD config/config.json /home/nobody/

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /trex \
    && wget --no-check-certificate $TREX_URL \
    && tar -xvf ./*.tar.gz  -C /trex \
    && rm *.tar.gz

WORKDIR /trex

ADD init.sh /trex/

# VOLUME ["/config"]

CMD ["/bin/bash", "init.sh"]
