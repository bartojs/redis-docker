FROM debian:wheezy
MAINTAINER bartojs

RUN apt-get update && apt-get install -qy build-essential wget

RUN wget -qO- http://download.redis.io/redis-stable.tar.gz | tar xz -C /usr/local
RUN cd /usr/local/redis-stable && make && make install
RUN cp -f /usr/local/redis-stable/src/redis-sentinel /usr/local/bin/
RUN mkdir /etc/redis && cat /usr/local/redis-stable/redis.conf | sed -e 's/^dir .*/dir \/data/' -e 's/^bind /#bind /' -e 's/^daemonize /#daemonize /' -e 's/^logfile /#logfile /' > /etc/redis/redis.conf

EXPOSE 6379
VOLUME /data
WORKDIR /data
CMD ["redis-server", "/etc/redis/redis.conf"]
