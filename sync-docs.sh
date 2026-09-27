#!/usr/bin/env bash
# Copies each Actor's README.md and BUILD-NOTES.md from its private code repo
# (sibling directory) into docs/<actor>/ here, so the docs are public while the
# code stays private. Run from anywhere; commit the result.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
parent="$(dirname "$here")"
for actor in linkedin-people-search-scraper google-ads-transparency-scraper linkedin-ad-library-scraper linkedin-jobs-scraper; do
  src="$parent/$actor"
  [ -d "$src" ] || { echo "skip $actor: no sibling dir"; continue; }
  mkdir -p "$here/docs/$actor"
  for f in README.md BUILD-NOTES.md; do
    [ -f "$src/$f" ] && cp "$src/$f" "$here/docs/$actor/$f" && echo "synced $actor/$f"
  done
  if [ "$actor" = linkedin-jobs-scraper ]; then
    mkdir -p "$here/docs/$actor/examples"
    cp "$src/examples/daily-monitor.json" "$src/examples/job.json" "$here/docs/$actor/examples/"
  fi
done
