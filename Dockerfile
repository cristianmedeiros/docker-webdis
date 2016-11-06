FROM redis:3.2.5-alpine

MAINTAINER Rob Powell <rob.p.tec@gmail.com>

RUN apk update

RUN apk add \
	make \
	wget \
	gcc \
	libevent-dev \
    libevent \
    unzip \
    alpine-sdk \
    bsd-compat-headers

RUN wget --no-check-certificate -O webdis.zip https://github.com/nicolasff/webdis/archive/0.1.2.zip && unzip webdis.zip -d /

ADD run-webdis.sh /tmp/

ADD webdis.json /tmp/

RUN cd /webdis-0.1.2/ && make && make install && cd ..

RUN rm -rf /webdis-0.1.2/ webdis.zip

RUN chmod a+x /tmp/run-webdis.sh

RUN apk del --purge wget make gcc alpine-sdk libevent-dev bsd-compat-headers

EXPOSE 7379

CMD ["/tmp/run-webdis.sh"]
