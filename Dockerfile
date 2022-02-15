FROM ubuntu:xenial
USER root
COPY hello_1.0.0_amd64.deb / 
CMD [ "out" ]



