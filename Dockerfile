FROM ubuntu:xenial
MAINTAINER Grow SDK Authors <hello@grow.io>

# Update system.
RUN apt-get update
RUN apt-get upgrade -y

# Set environment variables.
ENV TERM=xterm

# Install Node 8.
RUN apt-get install -y --no-install-recommends curl ca-certificates
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Install Grow dependencies.
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
python python-pip python-setuptools python-all-dev zip libc6 \
libyaml-dev libffi-dev libxml2-dev libxslt-dev libssl-dev \
git curl ssh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install NPM globals.
RUN npm install -g gulp

# Install App Engine - Python
RUN gcloud components install app-engine-python

# Confirm versions that are installed.
RUN node -v
RUN gulp -v
