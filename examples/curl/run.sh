#!/usr/bin/env bash
# Run the "Medium Scraper – Articles, Authors, Tags & Publications" Apify Actor synchronously and print the dataset items.
# Usage: export APIFY_TOKEN=your_apify_token && ./run.sh
set -euo pipefail
: "${APIFY_TOKEN:?Set APIFY_TOKEN first (Apify Console > Settings > API & Integrations)}"

curl -sS -X POST "https://api.apify.com/v2/acts/leadsbrary~medium-article-scraper/run-sync-get-dataset-items" \
  -H "Authorization: Bearer ${APIFY_TOKEN}" \
  -H "Content-Type: application/json" \
  -d @- <<'JSON'
{
  "authors": [
    "@medium"
  ],
  "publications": [
    "better-programming"
  ],
  "tags": [
    "machine-learning"
  ],
  "articleUrls": [],
  "maxResults": 3,
  "includeFullText": true,
  "proxyConfiguration": {
    "useApifyProxy": true
  }
}
JSON
