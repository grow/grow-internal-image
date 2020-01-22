FROM ubuntu:bionic
MAINTAINER Grow SDK Authors <hello@grow.io>

# Set environment variables.
ENV TERM=xterm

# Update system.
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
    software-properties-common curl ca-certificates gpg-agent \
    python python-pip python-setuptools python-all-dev \
    python3 python3-pip python3-setuptools python3-all-dev \
    pylint build-essential zip libc6 libyaml-dev libffi-dev \
    libxml2-dev libxslt-dev libssl-dev git ssh \
  && add-apt-repository ppa:longsleep/golang-backports \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# gcloud tool.
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Node.
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Install dependencies.
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    google-cloud-sdk google-cloud-sdk-app-engine-python golang-go nodejs \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add to path.
ENV PATH=$PATH:/usr/lib/go-1.13/bin
ENV PYTHONPATH="${PYTHONPATH}:/usr/lib/google-cloud-sdk/platform/google_appengine"
ENV GOPATH=$HOME/gocode
ENV PATH=$PATH:$GOPATH/bin

# Update pip.
RUN pip install --upgrade pip virtualenv pipenv \
  && pip3 install --upgrade pip virtualenv pipenv

# Install NPM globals.
RUN npm install -g gulp yarn

# Install github release uploader.
RUN go get -u github.com/tcnksm/ghr

# Confirm versions that are installed.
RUN echo "Node: `node -v`" \
  && echo "NPM: `npm -v`" \
  && echo "Yarn: `yarn --version`" \
  && echo "Gulp: `gulp -v`" \
  && echo "GCloud: `gcloud -v`" \
  && echo "Yarn: `yarn --version`" \
  && echo "Go: `go version`" \
  && echo "GHR: `ghr --version`"
