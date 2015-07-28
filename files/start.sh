#!/bin/bash

# Fail fast, including pipelines
set -e -o pipefail


FLAPJACK_CONFIG_DIR="/etc/flapjack/"
FLAPJACK_CONFIG_FILE="${FLAPJACK_CONFIG_DIR}/flapjack_config.yaml"

function flapjack_sanitize_config() {
    local host="${REDIS_PORT_6379_TCP_ADDR:-127.0.0.1}"
    local port="${REDIS_PORT_6379_TCP_PORT:-6379}"

    sed -e "s|REDIS_HOST|${host}|g" \
        -e "s|REDIS_PORT|${port}|g" \
        -i "$FLAPJACK_CONFIG_FILE"
}

function flapjack_start_server() {
    local binary="$FLAPJACK_BINARY"
    local config_dir="$FLAPJACK_CONFIG_DIR"
    local log_file="$FLAPJACK_LOG_FILE"

    case "$1" in
    # run just the server
    'server')
        exec "/var/lib/gems/2.1.0/gems/bundler-1.10.6/bin/bundle" \
             exec flapjack server start --no-daemonize 
             --
      ;;
    'test')
      /var/lib/gems/2.1.0/gems/bundler-1.10.6/bin/bundle exec flapjack --version
      ;;
    'shell')
        exec /bin/bash
    esac
}


# Set FLAPJACK_TRACE to enable debugging
[[ $FLAPJACK_TRACE ]] && set -x

function main() {
  flapjack_sanitize_config
  flapjack_start_server "$@"
}

main "$@"
