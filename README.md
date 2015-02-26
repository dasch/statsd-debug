statsd-debug
============

A simple Statsd server that outputs all events to standard out.

Running statsd-debug in Docker is trivial:

    docker run -p 8125:8125/udp dasch/statsd-debug
