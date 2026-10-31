# Agnes's Apify actors: pay-per-result scrapers for B2B intel and outbound

Competitive intel and outbound data for B2B teams. This is the index for my twelve Apify actors: the public ad libraries (LinkedIn, Google, Facebook and Instagram), LinkedIn people, profiles, companies, new hires and B2B leads, jobs on LinkedIn and Indeed, plus Google Hotels prices and Bilibili. There is no login to hand over, no LinkedIn cookies and no account of yours at risk. Pricing is pay per result: you are charged for the rows that clear each actor's check, and rows that don't are delivered with `charged: false` at $0.

Portfolio, with the same list and my write-ups: [agnesthedeveloper.github.io](https://agnesthedeveloper.github.io).

## Actors

### Ad intelligence

| Actor | What it does | Price | Code and docs |
|---|---|---|---|
| [![Run on Apify](https://apify.com/actor-badge?actor=agnes.developer.queen/linkedin-ad-library-scraper)](https://apify.com/agnes.developer.queen/linkedin-ad-library-scraper?utm_source=github&utm_medium=hub&utm_campaign=q4launch)<br>**LinkedIn Ad Library Scraper** | Every ad a company runs on LinkedIn: copy, creative, payer, run dates, impressions by country and targeting where LinkedIn publishes them. | $0.003 / ad (+$0.00005 / run) | [GitHub](https://github.com/agnesthedeveloper/linkedin-ad-library-scraper) |
| [![Run on Apify](https://apify.com/actor-badge?actor=agnes.developer.queen/google-ads-transparency-scraper)](https://apify.com/agnes.developer.queen/google-ads-transparency-scraper?utm_source=github&utm_medium=hub&utm_campaign=q4launch)<br>**Google Ads Transparency Scraper** | Every ad a brand runs on Google, by domain or advertiser name: text, image or video, first and last shown dates, countries. | $0.0025 / ad (+$0.00005 / run) | [GitHub](https://github.com/agnesthedeveloper/google-ads-transparency-scraper) |
| [![Run on Apify](https://apify.com/actor-badge?actor=agnes.developer.queen/meta-ad-library-scraper)](https://apify.com/agnes.developer.queen/meta-ad-library-scraper?utm_source=github&utm_medium=hub&utm_campaign=q4launch)<br>**Facebook Ad Library Scraper** | Every ad a brand runs on Facebook and Instagram: copy, image or video, start date, days running and EU reach. | $0.005 / ad (+$0.00005 / run) | [README on Apify](https://apify.com/agnes.developer.queen/meta-ad-library-scraper) |

### People and companies

| Actor | What it does | Price | Code and docs |
|---|---|---|---|
| [![Run on Apify](https://apify.com/actor-badge?actor=agnes.developer.queen/linkedin-people-search-scraper)](https://apify.com/agnes.developer.queen/linkedin-people-search-scraper?utm_source=github&utm_medium=hub&utm_campaign=q4launch)<br>**LinkedIn People Search Scraper** | Public LinkedIn profiles by job title, company and location. Charged only when the person's own headline confirms the title and company. | $0.015 / confirmed profile (+$0.005 / run) | [GitHub](https://github.com/agnesthedeveloper/linkedin-people-search-scraper) |
| [![Run on Apify](https://apify.com/actor-badge?actor=agnes.developer.queen/linkedin-profile-scraper)](https://apify.com/agnes.developer.queen/linkedin-profile-scraper?utm_source=github&utm_medium=hub&utm_campaign=q4launch)<br>**LinkedIn Profile Scraper** | Profile URLs in; name, headline, location, current and past companies, education and followers out. Private profiles are free. | $0.003 / profile (+$0.00005 / run) | [README on Apify](https://apify.com/agnes.developer.queen/linkedin-profile-scraper) |
| [![Run on Apify](https://apify.com/actor-badge?actor=agnes.developer.queen/linkedin-company-scraper)](https://apify.com/agnes.developer.queen/linkedin-company-scraper?utm_source=github&utm_medium=hub&utm_campaign=q4launch)<br>**LinkedIn Company Scraper** | Company URL or name in; industry, size, headquarters, founded year, website, specialties and followers out. | $0.005 / company (+$0.005 / run) | [GitHub](https://github.com/agnesthedeveloper/linkedin-company-scraper) |
| [![Run on Apify](https://apify.com/actor-badge?actor=agnes.developer.queen/linkedin-new-hires-finder)](https://apify.com/agnes.developer.queen/linkedin-new-hires-finder?utm_source=github&utm_medium=hub&utm_campaign=q4launch)<br>**LinkedIn New Hires Finder** | A company name or LinkedIn URL in; the decision makers who joined recently, with the month they started and the company they left. | $0.50 / new hire (+$0.00005 / run) | [README on Apify](https://apify.com/agnes.developer.queen/linkedin-new-hires-finder) |
| [![Run on Apify](https://apify.com/actor-badge?actor=agnes.developer.queen/b2b-leads-finder)](https://apify.com/agnes.developer.queen/b2b-leads-finder?utm_source=github&utm_medium=hub&utm_campaign=q4launch)<br>**B2B Leads Finder** | Public LinkedIn profiles by title, company and location, with email evidence where an address can be derived. | $0.004 / lead with verified email, $0.002 probable, $0.0005 without (+$0.00005 / run) | [README on Apify](https://apify.com/agnes.developer.queen/b2b-leads-finder) |

### Jobs

| Actor | What it does | Price | Code and docs |
|---|---|---|---|
| [![Run on Apify](https://apify.com/actor-badge?actor=agnes.developer.queen/linkedin-jobs-scraper)](https://apify.com/agnes.developer.queen/linkedin-jobs-scraper?utm_source=github&utm_medium=hub&utm_campaign=q4launch)<br>**LinkedIn Jobs Scraper** | Full job descriptions, company, location and posted dates, with a monitor mode that only delivers jobs you haven't seen. | $0.002 / job (+$0.00005 / run) | [GitHub](https://github.com/agnesthedeveloper/linkedin-jobs-scraper) |
| [![Run on Apify](https://apify.com/actor-badge?actor=agnes.developer.queen/indeed-jobs-scraper)](https://apify.com/agnes.developer.queen/indeed-jobs-scraper?utm_source=github&utm_medium=hub&utm_campaign=q4launch)<br>**Indeed Jobs Scraper** | Salary ranges, company ratings and optional full descriptions, with the same monitor mode and a group-by-company view. | $0.001 / job, $0.002 with description (+$0.00005 / run) | [README on Apify](https://apify.com/agnes.developer.queen/indeed-jobs-scraper) |

### Other

| Actor | What it does | Price | Code and docs |
|---|---|---|---|
| [![Run on Apify](https://apify.com/actor-badge?actor=agnes.developer.queen/google-hotels-scraper)](https://apify.com/agnes.developer.queen/google-hotels-scraper?utm_source=github&utm_medium=hub&utm_campaign=q4launch)<br>**Google Hotels Scraper** | Prices for the dates and guests you choose: nightly and total price, rating, reviews, star class, coordinates and website for every hotel on the results page. | $0.002 / hotel, $0.008 with offers (+$0.00005 / run) | [README on Apify](https://apify.com/agnes.developer.queen/google-hotels-scraper) |
| [![Run on Apify](https://apify.com/actor-badge?actor=agnes.developer.queen/bilibili-scraper)](https://apify.com/agnes.developer.queen/bilibili-scraper?utm_source=github&utm_medium=hub&utm_campaign=q4launch)<br>**Bilibili Scraper** | Video search, details, popular, danmaku, comments, subtitle transcripts and profiles. Charged only for rows delivered. | $0.012 / video, $0.008 / comment, no start fee | [README on Apify](https://apify.com/agnes.developer.queen/bilibili-scraper) |

Longer write-ups for four of them live in [`docs/`](docs/): input fields, output schema, measured runs, costs and pricing history. `sync-docs.sh` copies them in from the code repos.

## Pricing philosophy

- You pay per result, not per compute minute. The price in the table is the whole story, plus a tiny per-run start fee.
- Every row carries a `charged` flag. Rows that don't clear the actor's check (wrong company, incomplete job, duplicate) are still delivered so you can see them, with `charged: false` and a cost of $0.
- Every Apify account gets $5 of free platform credit each month, which is enough to try any of them on real inputs.

## Quick start

Get an API token from [Apify Console](https://console.apify.com/settings/integrations) and export it as `APIFY_TOKEN`.

curl, running the Google Ads Transparency Scraper and getting the items back in one call:

```bash
curl -X POST \
  "https://api.apify.com/v2/acts/agnes.developer.queen~google-ads-transparency-scraper/run-sync-get-dataset-items?token=$APIFY_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "domains": ["nike.com"], "region": "anywhere", "format": "all", "maxAdsPerAdvertiser": 20 }'
```

Python (`pip install apify-client`):

```python
import os
from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])
run = client.actor("agnes.developer.queen/linkedin-ad-library-scraper").call(
    run_input={"companies": ["HubSpot"], "maxAdsPerSearch": 20}
)
for ad in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(ad["advertiserName"], ad.get("headline"))
```

Node.js (`npm install apify-client`):

```js
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });
const run = await client.actor('agnes.developer.queen/linkedin-ad-library-scraper').call({
    companies: ['HubSpot'],
    maxAdsPerSearch: 20,
});
const { items } = await client.dataset(run.defaultDatasetId).listItems();
console.log(items.length, 'ads');
```

MCP: every actor here can be called from any MCP client through the [Apify MCP server](https://mcp.apify.com). Add it to your client and ask for the actor by name, for example `agnes.developer.queen/linkedin-jobs-scraper`.

Each actor's input schema is on its Apify page under the Input tab.

## Contact

Found a bug or want a field added? Open an issue on the actor's Issues tab on its [Apify Store page](https://apify.com/agnes.developer.queen). That's where I track and answer them.
