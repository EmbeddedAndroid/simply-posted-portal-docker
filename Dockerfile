#
# Simply Posted Portal.
#

# Pull base image.
FROM aarch64/ubuntu:16.04

# Install.
RUN \
  apt-get clean && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y git python python-pip libpq-dev libjpeg-dev zlib1g-dev && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts
ADD serve.sh /root/serve.sh

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD /root/serve.sh
