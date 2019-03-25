FROM alpine:latest
LABEL maintainer "Raman Shyshniou <rommer@ibuffed.com>"

COPY . /opt
RUN /opt/build.sh
ENTRYPOINT [ "/sbin/tini", "--", "/opt/entrypoint.sh" ]
