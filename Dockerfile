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

# Install gcloud tool.
RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Install dependencies.
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
python python-pip python-setuptools python-all-dev pylint \
nodejs build-essential zip libc6 \
libyaml-dev libffi-dev libxml2-dev libxslt-dev libssl-dev \
git curl ssh google-cloud-sdk google-cloud-sdk-app-engine-python

# Add gcloud to path.
ENV PATH="${PATH}:/usr/lib/google-cloud-sdk/platform/google_appengine"

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Update pip
RUN pip install --upgrade pip

# Install Virtual Env
RUN pip install virtualenv

# Install NPM globals.
RUN npm install -g gulp

# Confirm versions that are installed.
RUN node -v
RUN gulp -v
RUN gcloud -v
