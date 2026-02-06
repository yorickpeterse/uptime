# Uptime

> Mom, can we have an uptime monitoring solution?
>
> Honey, we have uptime monitoring at home.
>
> Uptime monitoring at home:

This is a simple Docker/Podman container that uses curl to monitor website
response timings and sends them to an InfluxDB/VictoriaMetrics database. This
data may then be used to monitor the uptime and timings over time, send alerts,
etc. Basically Uptime Kuma and such but with graphs that actually work and can
show more than just the last 24 hours of data.

## Requirements

- Docker/Podman

## License

All source code in this repository is licensed under the Mozilla Public License
version 2.0, unless stated otherwise. A copy of this license is found in the
file "LICENSE".
