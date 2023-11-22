# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Install required dependencies
RUN apt-get update && \
    apt-get install -y wget tar && \
    rm -rf /var/lib/apt/lists/*

# Download and install TMAS CLI
RUN wget -O tmas-cli.tar.gz https://cli.artifactscan.cloudone.trendmicro.com/tmas-cli/latest/tmas-cli_Linux_x86_64.tar.gz && \
    tar -xzvf tmas-cli.tar.gz && \
    mv tmas /usr/local/bin/ && \
    rm tmas-cli.tar.gz

# Set environment variables
ENV TMAS_API_KEY=<TMAS_API_KEY>
ENV SCAN_IMAGE_PATH=/app/scan_image.tar  

# Set up proxy configuration if needed
# ENV NO_PROXY=<comma-separated-list-of-hosts>
# ENV HTTP_PROXY=http://proxy.example.com
# ENV HTTPS_PROXY=https://proxy.example.com
# ENV PROXY_USER=<optional-username-for-proxy-authentication>
# ENV PROXY_PASS=<optional-password-for-proxy-authentication>

# Cleanup temporary files after scan execution
# RUN echo $TEMPDIR && ls $TEMPDIR | grep "stereoscope-" && cd $TEMPDIR && rm -rf ./stereoscope-* && ls $TEMPDIR | grep "stereoscope-"

# Define the default command to run when the container starts
ENTRYPOINT ["tmas", "scan", "--platform", "linux/amd64", "docker-archive:$SCAN_IMAGE_PATH"]

