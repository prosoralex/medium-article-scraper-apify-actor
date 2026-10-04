# Medium Scraper – Articles, Authors, Tags & Publications — Apify Actor usage guide

[![Run on Apify](https://img.shields.io/badge/Apify-Run%20this%20Actor-24C1E0)](https://apify.com/leadsbrary/medium-article-scraper?fpr=aupara)
[![Try Apify free](https://img.shields.io/badge/Apify-Try%20it%20free-24C1E0)](https://console.apify.com/sign-up?fpr=aupara)

Medium scraper: extract public articles by author, publication, tag or URL with title, full text, markdown, tags, claps, responses, dates and reading time. Export JSON, CSV or Excel. From $1 per 1,000 results.

> **This repository does not contain the Actor's source code.** The Actor is closed-source and
> runs on Apify's infrastructure. This repo is documentation plus ready-to-run client examples
> (curl, Python, JavaScript) that call the hosted Actor with **your own** Apify API token.

**Run it on Apify →** [https://apify.com/leadsbrary/medium-article-scraper?fpr=aupara](https://apify.com/leadsbrary/medium-article-scraper?fpr=aupara)

## What it does

This Medium scraper collects **public Medium articles** by author, publication, tag or direct article URL. For every article it returns the title, subtitle, author, publication, tags, publication and update dates, reading time, claps, responses and — optionally — the full text as plain text and Markdown. Results are stored in an Apify dataset that you can export as JSON, CSV, Excel, XML or HTML, or read through the API.

It uses Medium's own public web endpoints, needs no Medium account and no API key, and works with Apify datacenter proxies. It only returns what is publicly visible: no emails, no private data, and no bypass of the Medium paywall.

## Use cases

- Pull the full public article history of a Medium author or publication into a spreadsheet or database
- Track new articles on a tag (e.g. 'machine-learning') for topic research or a curated newsletter
- Benchmark competitors' content: titles, tags, reading time, claps and responses over time
- Build a structured content dataset (title, text, tags, dates) for internal research and analytics
- Enrich a list of known article URLs with metadata and public full text


## Input

| Field | Type | Required | Description |
|---|---|---|---|
| `authors` | array | no | Medium authors: @username, username or profile URL (https://medium.com/@username). Their latest articles are scraped. |
| `publications` | array | no | Publication slug or URL (e.g. better-programming or https://medium.com/the-startup). |
| `tags` | array | no | Tag slugs or tag URLs (e.g. machine-learning or https://medium.com/tag/python). Newest articles first. |
| `articleUrls` | array | no | Direct article URLs (the 10–12 character id at the end of the URL is used). |
| `maxResults` | integer | no | Stop after this many articles in total (also protects your spending). |
| `maxResultsPerSource` | integer | no | Cap for each author, publication or tag. Empty = only the total limit applies. |
| `includeFullText` | boolean | no | Fetch each article's public text (text, markdown, word count). Member-only articles only expose the public preview, flagged with isMemberOnly/textIsPreviewOnly. Disable for faster metadata-only runs. |
| `publishedAfter` | string | no | Only articles first published on or after this date (YYYY-MM-DD). |
| `proxyConfiguration` | object | no | Datacenter proxy is enough for Medium. |

The full input form (with defaults and validation) is on the [Actor page](https://apify.com/leadsbrary/medium-article-scraper?fpr=aupara).


## Output (sample item)

Sample trimmed for readability (long texts and lists are shortened) — a real run returns the complete data.

```json
{
  "articleId": "62edea66ffa4",
  "url": "https://medium.com/blog/updating-our-rules-june-2023-62edea66ffa4",
  "canonicalUrl": "https://medium.com/blog/updating-our-rules-june-2023-62edea66ffa4",
  "title": "Updating Our Rules — June 2023",
  "subtitle": "This month, we are updating our Rules. As the world evolves, so do the ways in which people use Medium. To accommodate this, we regularly…",
  "authorName": "Medium",
  "authorUsername": "Medium",
  "authorUrl": "https://medium.com/@Medium",
  "publicationName": "The Medium Blog",
  "publicationSlug": "blog",
  "publicationDomain": null,
  "publishedAt": "2023-06-28T18:01:22.039Z",
  "updatedAt": "2023-06-28T18:01:22.039Z",
  "readingTimeMinutes": 1,
  "claps": 5130,
  "responses": 69,
  "tags": [
    "medium",
    "rules"
  ],
  "isMemberOnly": false,
  "imageUrl": null,
  "text": "Updating Our Rules — June 2023\n\nThis month, we are updating our Rules. As the world evolves, so do the ways in which people use Medium. To accommodate this, we regularly assess our rules, and adjust them accordingly.\n\nWe believe that through helping people share their experiences…",
  "markdown": "## Updating Our Rules — June 2023\n\nThis month, we are updating our Rules. As the world evolves, so do the ways in which people use Medium. To accommodate this, we regularly assess our rules, and adjust them accordingly.\n\nWe believe that through helping people share their experien…",
  "wordCount": 264,
  "textIsPreviewOnly": false,
  "sourceType": "author",
  "sourceInput": "@medium",
  "scrapedAt": "2026-10-03T22:37:20.560Z"
}
```

## Pricing

Pay only for results: about **$1.50 per 1,000 results** on the Apify Free plan, down to **$1.00 per 1,000** on paid Apify plans.

Apify platform usage (compute) is billed by Apify on top of the per-result price — about **$0.02 per 1,000 results** in our measured test runs (estimate, varies with input). Tip: keep only the output formats and options you need to reduce it.

Prices can change — the [Actor page](https://apify.com/leadsbrary/medium-article-scraper?fpr=aupara) always shows the current pricing.

## Quick start

You need an Apify account and an API token (Apify Console → **Settings → API & Integrations**).
Never commit your token: export it as the `APIFY_TOKEN` environment variable.

### cURL

```bash
curl -X POST "https://api.apify.com/v2/acts/leadsbrary~medium-article-scraper/run-sync-get-dataset-items" \
  -H "Authorization: Bearer $APIFY_TOKEN" \
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
```

### Python (`apify-client`)

```python
import os
from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

run_input = {
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
    "includeFullText": True,
    "proxyConfiguration": {
        "useApifyProxy": True
    }
}

run = client.actor("leadsbrary/medium-article-scraper").call(run_input=run_input)
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item)
```

### JavaScript (`apify-client`)

```javascript
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

const runInput = {
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
};

const run = await client.actor('leadsbrary/medium-article-scraper').call(runInput);
const { items } = await client.dataset(run.defaultDatasetId).listItems();
console.log(items);
```

Runnable versions live in [`examples/`](./examples).

## Troubleshooting

- **401 / "User was not found or authentication token is not valid"** — check that `APIFY_TOKEN` is set and copied completely.
- **The run finished but the dataset is empty** — widen your search input or check the run log on the Apify Console.
- **Run stops early** — you may have reached the maximum cost per run you set in Apify; raise it in the run options.
- **Need something else?** Open an issue in this repository or use the Issues tab on the Actor page.

## Don't have an Apify account yet?

[Sign up here](https://console.apify.com/sign-up?fpr=aupara) — new accounts get $5 of free platform usage every month, enough to try most Actors without paying upfront.
Browse the full [Apify Store](https://apify.com/store?fpr=aupara) or [all Actors from this developer](https://apify.com/leadsbrary?fpr=aupara).

## Links

- Actor page: [https://apify.com/leadsbrary/medium-article-scraper?fpr=aupara](https://apify.com/leadsbrary/medium-article-scraper?fpr=aupara)
- All Actors from this developer: [https://apify.com/leadsbrary?fpr=aupara](https://apify.com/leadsbrary?fpr=aupara)
- Apify API reference: [https://docs.apify.com/api/v2](https://docs.apify.com/api/v2)

## Keywords

medium scraper, medium article scraper, medium publication scraper, medium rss scraper, medium author articles, medium tag scraper, scrape medium articles, medium api, medium posts export, medium blog scraper, medium to csv, medium content extractor

#medium #mediumscraper #webscraping #contentresearch #seo #rss #blogscraper #apify #dataextraction #contentmarketing

## License

The example code in this repository is released under the MIT License — see [LICENSE](./LICENSE).
It does not cover the Actor itself, which remains closed-source and is operated by its developer on Apify.
