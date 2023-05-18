# Torrents.csv

* https://git.torrents-csv.ml/heretic/
<!-- Torrents.csv - An open source, collaborative repository of torrents, with a self-hostable web server.   -->

### Docker Compose
* get [nginx.conf](https://git.torrents-csv.ml/heretic/torrents-csv-server/src/branch/main/docker/prod/nginx.conf)
```
version: '3.7'

networks:
  # communication to web and clients
  torrentsexternalproxy:
  # communication between lemmy services
  torrentsinternal:
    driver: bridge
    internal: true

services:
  proxy:
    image: nginx:1-alpine
    networks:
      - torrentsinternal
      - torrentsexternalproxy
    ports:
    # actual and only port facing any connection from outside 
      - "8904:8904"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    restart: always
    depends_on:
      - torrents-csv
      - torrents-csv-ui-perseus

  torrents-csv:
    image: martadinata666/torrents-csv:latest
    restart: always
    hostname: torrents-csv
    networks:
      - torrentsinternal
    environment:
      TORRENTS_CSV_DB_FILE: /app/torrents.db 
      TORRENTS_CSV_FRONT_END_DIR: /app/dist

  torrents-csv-ui-perseus:
    image: martadinata666/torrents-csv:ui
    restart: always
    networks:
      - torrentsinternal
    environment:
      PERSEUS_HOST: "0.0.0.0"
      TORRENTS_CSV_ENDPOINT: "http://torrents-csv:8902"
```
Access from http://host-ip:8904

## Command Line Searching

### Requirements

- [ripgrep](https://github.com/BurntSushi/ripgrep)

### Running

```
git clone --recurse-submodules https://git.torrents-csv.ml/heretic/torrents-csv-server
cd torrents-csv-server
./search.sh "bleh season 1"
bleh season 1 (1993-)
	seeders: 33
	size: 13GiB
	link: magnet:?xt=urn:btih:INFO_HASH_HERE
```

## API

A JSON output of search results is available at:

`http://localhost:8904/service/search?q=[QUERY]&size=[NUMBER_OF_RESULTS]&page=[PAGE]&type=[torrent | file]`

New torrents are at:

`http://localhost:8904/service/new?size=[NUMBER_OF_RESULTS]&page=[PAGE]&type=[torrent | file]`

