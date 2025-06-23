#!/bin/bash
set -e

# Remove existing server PID if exists
rm -f /code-challenge/backend/tmp/pids/server.pid

# Run the main container command
exec "$@"