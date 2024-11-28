FROM alpine as db
WORKDIR /app
RUN apk add git && \
    git clone https://git.torrents-csv.com/heretic/torrents-csv-data && \
    cd torrents-csv-data && \
    ./import_to_sqlite.sh && \
    mv ./torrents.db ../

# Import the current csv to a sqlite3 db file, to use as a consistent store.
./import_to_sqlite.sh
FROM --platform=$BUILDPLATFORM tonistiigi/xx:master AS xx

FROM --platform=$BUILDPLATFORM rust:alpine as base
RUN apk add clang lld git file tree musl-dev
COPY --from=xx / /

FROM base as builder
ARG TARGETPLATFORM
RUN xx-info env
ARG RUSTRELEASEDIR="release"
WORKDIR /app
RUN xx-apk add --no-cache musl-dev
RUN rustup target add aarch64-unknown-linux-musl
COPY Cargo.toml Cargo.lock ./
COPY src src

RUN case ${TARGETPLATFORM} in \
         "linux/amd64")  CARGO_BUILD_TARGET=x86_64-unknown-linux-musl  ;; \
         "linux/arm64")  CARGO_BUILD_TARGET=aarch64-unknown-linux-musl  ;; \
    esac \
    && xx-cargo build --release --config net.git-fetch-with-cli=true --target $CARGO_BUILD_TARGET --target-dir /app/bin \
    && xx-verify --static /app/bin/$CARGO_BUILD_TARGET/release/torrents-csv-service \
    && cp /app/bin/$CARGO_BUILD_TARGET/release/torrents-csv-service /app/torrents-csv-service

# reduce binary size
FROM alpine as stripper
RUN apk add binutils
WORKDIR /app
COPY --from=builder /app/torrents-csv-service /app/torrents-csv-service
RUN strip /app/torrents-csv-service

# The runner
FROM alpine
RUN addgroup -S myuser && adduser -S myuser -G myuser
ENV TORRENTS_CSV_DB_FILE=/app/torrents.db 
ENV TORRENTS_CSV_FRONT_END_DIR=/app/dist
# Copy resources
COPY --from=stripper /app/torrents-csv-service /app/torrents-csv-service
COPY --from=db /app/torrents.db /app/torrents.db
EXPOSE 8080
USER myuser
CMD ["/app/torrents-csv-service"]
