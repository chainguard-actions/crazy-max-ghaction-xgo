#!/bin/sh
# Fake docker for xgo testing.
# xgo calls: docker pull <image> and docker run -v <src>:/source -v <dest>:/build ...
case "$1" in
  pull)
    echo "fake-docker: skipping pull of $2"
    exit 0
    ;;
  run)
    # Find the host path mounted as /build (xgo output directory)
    dest_dir=""
    prev=""
    for arg in "$@"; do
      if [ "$prev" = "-v" ]; then
        host="${arg%%:*}"
        rest="${arg#*:}"
        container="${rest%%:*}"
        if [ "$container" = "/build" ]; then
          dest_dir="$host"
        fi
      fi
      prev="$arg"
    done
    if [ -n "$dest_dir" ]; then
      mkdir -p "$dest_dir"
      echo "fake-compiled-binary" > "$dest_dir/hello-linux-amd64"
      chmod +x "$dest_dir/hello-linux-amd64"
      echo "fake-docker: created output in $dest_dir"
    else
      echo "fake-docker: no /build mount found in: $*"
    fi
    exit 0
    ;;
  *)
    exit 0
    ;;
esac
