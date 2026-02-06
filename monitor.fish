#!/usr/bin/env fish

if ! test -n "$DB_IP"
    echo 'The DB_IP variable must be set'
    exit 1
end

if ! test -n "$DB_PORT"
    echo 'The DB_PORT variable must be set'
    exit 1
end

while true
    for host in $argv
        set timings (
            curl --fail \
                --show-error \
                --silent \
                --connect-timeout 5 \
                --max-time 5 \
                --write-out "%{time_connect}\n%{time_appconnect}\n%{time_total}" \
                --output /dev/null \
                --head \
                --user-agent "Uptime bot (https://github.com/yorickpeterse/uptime)" \
                https://$host
        )

        if test $status -eq 0
            set time_tcp $timings[1]
            set time_tls $timings[2]
            set time_sum $timings[3]

            echo "http_response_times,host=$host tcp=$time_tcp,tls=$time_tls,sum=$time_sum" \
                | ncat --udp $DB_IP $DB_PORT
            echo "$host: $time_sum seconds"
        end

        # Wait a little bit in between each site in case they're all on the same
        # server.
        sleep (random 1 10)
    end

    # Sleep with a random interval so we're less likely to miss outliers that
    # happen to be in between an otherwise fixed interval.
    sleep (random 180 300)
end
