###
# Docker build file for diamond
###
FROM baseboxorg/coin-builder:latest
MAINTAINER Boxup

# deal with installation warnings
ENV TERM xterm
# allow easy versioning of images
ENV TESTING 0.2.0

VOLUME /data/buildOutput

# Now let's build diamond
WORKDIR /home/development
RUN git clone https://github.com/dmdcoin/diamond.git
WORKDIR /home/development/diamond/src
RUN mkdir obj
#
# We have to tweak the buildfile - env vars don't always get applied
#
RUN sed -i "s/USE_UPNP:=0/USE_UPNP:=-/" makefile.unix
ENV LDFLAGS "-static"
ENV USE_UPNP - 
ENV USE_IPV6 0
ADD build.sh /home/development/diamond/src/build.sh
ADD deploy.sh /home/development/diamond/src/deploy.sh
ADD bootstrap.sh /home/development/diamond/src/bootstrap.sh
#ENTRYPOINT ["make", "-f", "makefile.unix"]
ENTRYPOINT ["/home/development/diamond/src/bootstrap.sh"]
