FROM alpine:3

RUN apk add --update --quiet nmap-ncat fish curl
ADD monitor.fish /monitor.fish
ENTRYPOINT ["/usr/bin/fish", "monitor.fish"]
