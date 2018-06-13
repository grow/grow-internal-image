FROM ubuntu:bionic
MAINTAINER Grow Authors <hello@grow.io>

# Update system.
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends software-properties-common curl wget

# Set environment variables.
ENV TERM=xterm

# Set environment variables
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Add Repositories
RUN add-apt-repository ppa:gophers/archive

# Install dependencies.
RUN apt-get update
RUN apt-get install -y --no-install-recommends python3 python3-pip python3-dev \
pylint build-essential zip libc6 nodejs npm \
libyaml-dev libffi-dev libxml2-dev libxslt-dev libssl-dev git ssh golang-1.9-go

# Add go to path.
ENV PATH=$PATH:/usr/lib/go-1.9/bin
ENV GOPATH=$HOME/gocode
ENV PATH=$PATH:$GOPATH/bin

# Update pip.
RUN pip3 install --upgrade pip

# Install Virtual Env
RUN pip3 install virtualenv
RUN pip3 install pipenv

# Install github release uploader.
RUN go get -u github.com/tcnksm/ghr

# Clean up APT.
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Clean up Temp files.
RUN rm -rf /tmp/* /var/tmp/*

# Confirm versions that are installed.
RUN python -v
RUN pip3 --version
RUN pipenv --version
RUN node -v
RUN npm --version
RUN go version
RUN ghr --version
