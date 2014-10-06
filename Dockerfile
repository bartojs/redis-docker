FROM debian:wheezy
MAINTAINER bartojs

RUN apt-get update && apt-get install -qy build-essential

ADD http://download.redis.io/redis-stable.tar.gz /tmp/
RUN cd /tmp && tar xzf redis-stable.tar.gz
RUN cd /tmp/redis-stable && make && make install
RUN cp -f /tmp/redis-stable/src/redis-sentinel /usr/local/bin/
RUN mkdir /etc/redis && cat /tmp/redis-stable/redis.conf | sed -e 's/^dir .*/dir \/data/' -e 's/^bind /#bind /' -e 's/^daemonize /#daemonize /' -e 's/^logfile /#logfile /' > /etc/redis/redis.conf

EXPOSE 6379
VOLUME ["/data"]
WORKDIR /data
CMD ["redis-server", "/etc/redis/redis.conf"]
