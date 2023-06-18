FROM alpine:latest

RUN apk update && apk add bash && apk add openssl && apk add git
WORKDIR /var/output
RUN git clone https://github.com/BenMorel/dev-certificates.git .
RUN ./create-ca.sh
RUN ./create-certificate.sh dev.local
RUN chown -R 1000:1000 .
CMD find . -name \*.key -exec cp {} /var/cert \; && find . -name \*.crt -exec cp {} /var/cert \;
