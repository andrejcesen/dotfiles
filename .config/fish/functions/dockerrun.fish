function dockerrun --description 'Run Docker Container'

  switch $argv[1]

    # automatically update running Docker containers
    case watchtower
      docker run -d \
        --name watchtower \
        -v /var/run/docker.sock:/var/run/docker.sock \
          v2tec/watchtower

    # unifi controller (web UI: https://localhost:8443)
    case unifi
      docker run -d \
        --name unifi \
        --init \
        -p 3478:3478/udp \
        -p 8080:8080/tcp \
        -p 8443:8443/tcp \
        -p 10001:10001/udp \
        -e TZ='Europe/Ljubljana' \
        -e RUNAS_UID0='false' \
        -e UNIFI_UID=(id -u) \
        -e UNIFI_GID=(id -g) \
        -v ~/unifi:/unifi \
          jacobalberty/unifi:stable

  end

end