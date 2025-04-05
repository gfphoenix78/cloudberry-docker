# Base on RockyLinux 9 official image
FROM quay.io/rockylinux/rockylinux:9

# Maintainer information (optional)
LABEL maintainer="gfphoenix78@gmail.com"

# Copy package list to container
COPY build_install_packages.txt /tmp/

# Install packages and clean cache
RUN dnf update -y
RUN dnf install -y epel-release
RUN dnf install -y $(tr '\n' ' ' < /tmp/build_install_packages.txt) && \
    dnf clean all

