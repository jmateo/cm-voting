# Use the official go docker image built on debian.
FROM golang

#Install dnsutils
RUN apt-get update && \
  apt-get install -q -y dnsmasq dnsutils

# Grab the source code and add it to the workspace.
ADD . /go/src/github.com/karesti/cm-voting

ADD ./app/db/agenda.json /go/app/db/agenda.json

# Install revel and the revel CLI.
RUN go get github.com/revel/revel
RUN go get github.com/revel/cmd/revel

#Install Mgo driver
RUN go get gopkg.in/mgo.v2
RUN go get golang.org/x/crypto/bcrypt

ENTRYPOINT revel run github.com/karesti/cm-voting 9000

# Open up the port where the app is running.
EXPOSE 9000

