FROM ubuntu:18.04

ARG MONGODB_VERSION=${MONGODB_VERSION}
ENV MONGODB_VERSION=${MONGODB_VERSION}

LABEL MAINTAINER="Christian Winther <jippignu@gmail.com>"

COPY docker-install.sh /root
RUN bash /root/docker-install.sh

ADD start-pritunl /bin/start-pritunl

EXPOSE 80
EXPOSE 443
EXPOSE 1194
EXPOSE 1194/udp

ENTRYPOINT ["/bin/start-pritunl"]

CMD ["/usr/bin/tail", "-f","/var/log/pritunl.log"]
