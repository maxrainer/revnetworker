Apache Reverse Proxy for Networker Docker

start with:
docker run --link networker:networker --name revnetworker -v /opt/apache:/opt/apache -p 444:443 -itd ntsdev/revnetworker
