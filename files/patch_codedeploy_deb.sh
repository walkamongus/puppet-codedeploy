#!/bin/bash
# Repack codedeploy-agent .deb to add ruby3.3 as a dependency alternative.
# Idempotent: exits 0 if ruby3.3 is already present in the control file.
set -e

DEB="/tmp/codedeploy-agent.deb"
PATCHED="/tmp/codedeploy-agent-patched.deb"
WORKDIR="/tmp/codedeploy-repack"

# Check if already patched
if [ -f "$PATCHED" ]; then
  if dpkg-deb -I "$PATCHED" | grep -q "ruby3.3"; then
    exit 0
  fi
fi

# Check if upstream already includes ruby3.3
if dpkg-deb -I "$DEB" | grep -q "ruby3.3"; then
  cp "$DEB" "$PATCHED"
  exit 0
fi

# Repack with ruby3.3 added
rm -rf "$WORKDIR"
mkdir -p "$WORKDIR"
dpkg-deb -R "$DEB" "$WORKDIR"
sed -i 's/ruby3\.2/ruby3.2 | ruby3.3/' "$WORKDIR/DEBIAN/control"
dpkg-deb -b "$WORKDIR" "$PATCHED"
rm -rf "$WORKDIR"
