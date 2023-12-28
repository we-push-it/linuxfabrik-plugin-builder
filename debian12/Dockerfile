FROM debian:bookworm
SHELL ["/bin/bash", "-c"]
WORKDIR /repos
COPY . ./
RUN chmod +x /repos/docker-run.sh
ENTRYPOINT ["/repos/docker-run.sh"]
