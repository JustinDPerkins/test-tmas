FROM ubuntu:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY . /tmas
WORKDIR /tmas

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["./tmas.sh"]
