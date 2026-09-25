# LinkedIn Ad Library Scraper: competitor ads with copy, pictures, videos, impressions and targeting

LinkedIn Ad Library Scraper is an Apify Actor that pulls the ads a company runs on LinkedIn from the public Ad Library, by company name, keyword or payer, and returns the ad itself, who paid for it, and, where LinkedIn publishes them, its run dates, impressions by country and targeting. No LinkedIn account or cookies.

## Pricing

| Event | Price | You pay when |
|---|---|---|
| Actor start | $0.00005 | once per run |
| Ad | $0.003 | an ad is delivered with its ID, its advertiser and its content (text, headline, picture or video) |

**That is $3 per 1,000 ads. Ads with no text, picture or video are delivered free, with their link.**

## The ad itself, with what LinkedIn knows about it

- Every ad gives the advertiser, the payer, the ad text, the headline, the picture or the video, and where the ad links to.
- Video ads give the MP4 LinkedIn serves, highest quality, and the poster frame.
- Message ads give the sender, the full message and the button text.
- Ads shown in the European Union also give the first and last day they ran, the impressions range, the share of impressions per country, and the targeting: languages, locations, and which of audience, demographic, company, education, job and interests were targeted or excluded. LinkedIn publishes this for EU-shown ads only; a company that advertises in Europe has it on most ads, a US-only advertiser on none.

```json
{
    "advertiserName": "HubSpot",
    "payer": "HubSpot, Inc.",
    "adFormat": "Single Image Ad",
    "text": "$1M to $100M ARR in 18 months. Stuart Shingler, Legora, on how fast-growth companies build trust while they innovate. London, 17 November.",
    "headline": "GROW Europe 2026 · London · Register Today",
    "imageUrl": "https://media.licdn.com/dms/image/v2/D4D10AQGshA0JBhq0cA/image-shrink_1280/...",
    "clickUrl": "https://www.hubspot.com/grow-europe?utm_source=linkedin&utm_medium=paid&...",
    "firstShown": "2026-09-23",
    "lastShown": "2026-09-25",
    "totalImpressions": "5k-10k",
    "impressionsByCountry": [
        { "country": "United Kingdom", "share": 91 },
        { "country": "Ireland", "share": 9 }
    ],
    "targeting": {
        "language": { "includes": ["English"], "excludes": [] },
        "location": { "includes": ["Ireland", "United Kingdom"], "excludes": [] },
        "parameters": [
            { "parameter": "Company", "targeted": true, "excluded": true },
            { "parameter": "Job", "targeted": true, "excluded": false }
        ]
    }
}
```

## How it works

```
company names, keywords, payers or Ad Library URLs
            |
            v
Ad Library search, 24 ads per page, newest first
            |
            v
for each ad, read its detail page: advertiser link, payer, dates,
impressions and targeting where LinkedIn publishes them
            |
            +--> ID, advertiser and content  -->  Ad (charged)
            |
            +--> no content                  -->  delivered free with the link
```

The Ad Library answers browsers only, so pages load in a headless browser on residential proxy, with pictures, fonts and scripts blocked to keep it fast. Turn off `withDetails` to skip the detail pages; the run is then about five times faster and returns what the search results show.

## What data does it extract

| Field | What it is |
|---|---|
| `adId`, `adUrl` | The ad's ID and page in the Ad Library |
| `advertiserName`, `advertiserId`, `advertiserType`, `advertiserUrl` | The advertiser, its LinkedIn company ID or member slug, and its page |
| `payer` | Who paid for the ad, as LinkedIn states it |
| `adFormat`, `creativeType` | Single Image Ad, Video Ad, Message Ad, LinkedIn Article Ad, Job Ad, and LinkedIn's creative type code |
| `text`, `headline`, `description` | The ad copy |
| `imageUrl`, `images` | The ad's picture, and every picture on it |
| `videoUrl`, `videoPosterUrl` | The MP4 and poster frame of a video ad |
| `clickUrl` | Where the ad links to |
| `messageSender`, `callToAction` | Sender and button text of a Message Ad |
| `firstShown`, `lastShown` | When the ad ran, for ads shown in the EU |
| `totalImpressions`, `impressionsLow`, `impressionsHigh` | LinkedIn's impressions range, as text and as numbers |
| `impressionsByCountry` | Each country with its share of impressions in percent |
| `targeting` | Languages, locations and other facets with includes and excludes, and which parameter groups were targeted or excluded |
| `detailsRead` | True when the detail page was read |
| `search` | The search that returned this ad |
| `isNew` | In monitor mode, true when the ad is new since your last run |
| `charged`, `reason` | Whether the row was charged, and why |

## What is NOT returned

- Ad spend or budgets. LinkedIn does not publish them.
- Run dates, impressions or targeting for ads that were not shown in the European Union. LinkedIn publishes these for EU-shown ads only.
- Exact impression counts. LinkedIn gives a range such as 5k-10k.
- The specific companies, job titles or audiences targeted. LinkedIn shows which parameter groups were used, not their values.
- Clicks, engagement or landing page performance.
- Ads LinkedIn has removed from the Ad Library.

## Quick start

1. Open the Actor and enter a competitor's name, for example `HubSpot`.
2. Optionally choose countries and a date range.
3. Run it and open the Ads table, or download JSON, CSV or Excel.

```json
{ "companies": ["HubSpot"], "maxAdsPerSearch": 20 }
```

## Monitor mode

Set `onlyNewSinceLastRun` to true and schedule the run daily or weekly. The first run delivers current ads up to your limit and remembers every ad it saw. Each later run delivers only ads that appeared since, marked `isNew`, and you pay only for those.

## Input

```json
{
    "companies": ["HubSpot", "Salesforce"],
    "keywords": ["webinar"],
    "countries": ["DE", "FR"],
    "dateOption": "last-30-days",
    "maxAdsPerSearch": 100,
    "withDetails": true,
    "onlyNewSinceLastRun": false
}
```

| Field | Type | Default | Description |
|---|---|---|---|
| `companies` | array | | Advertiser names as they appear on LinkedIn |
| `keywords` | array | | Words that appear in the ad. Each keyword is its own search |
| `payers` | array | | The entity that paid for the ads |
| `startUrls` | array | | Search URLs copied from the Ad Library, with filters already set |
| `countries` | array | all | ISO two-letter country codes such as `DE` or `FR`. Only ads shown in those countries. `EU` is not a code and matches nothing; list the member states instead |
| `dateOption` | string | `last-30-days` | `last-30-days`, `current-month`, `current-year`, `last-year` or `custom-date-range` with `startDate` and `endDate` |
| `minImpressions`, `maxImpressions` | integer | | Impressions bounds. LinkedIn applies them to EU-shown ads only, so every other ad is dropped |
| `maxAdsPerSearch` | integer | 100 | Stop after this many ads per company, keyword, payer or URL, up to 5,000 |
| `withDetails` | boolean | true | Read each ad's detail page for the payer, dates, impressions and targeting |
| `onlyNewSinceLastRun` | boolean | false | Monitor mode, deliver only ads new since the last run of the same search |
| `proxyConfiguration` | object | Apify residential | The Ad Library blocks datacenter IPs |

## Output

One full record from a real run.

```json
{
    "adId": "1558773703",
    "adUrl": "https://www.linkedin.com/ad-library/detail/1558773703",
    "advertiserName": "HubSpot",
    "advertiserId": "68529",
    "advertiserType": "company",
    "advertiserUrl": "https://www.linkedin.com/company/68529",
    "payer": "HubSpot, Inc.",
    "adFormat": "Single Image Ad",
    "creativeType": "SPONSORED_STATUS_UPDATE",
    "text": "$1M to $100M ARR in 18 months. Stuart Shingler, Legora, on how fast-growth companies build trust while they innovate. London, 17 November.",
    "headline": "GROW Europe 2026 · London · Register Today",
    "description": null,
    "imageUrl": "https://media.licdn.com/dms/image/v2/D4D10AQGshA0JBhq0cA/image-shrink_1280/B4DaDP9g74HMAc-/0/1790195405027/2png?e=2147483647&v=beta&t=uu-v3Wv8B56hQBJAD5VjRRV3DN-EoRbg-UMe2X3kaSk",
    "images": [
        "https://media.licdn.com/dms/image/v2/D4D10AQGshA0JBhq0cA/image-shrink_1280/B4DaDP9g74HMAc-/0/1790195405027/2png?e=2147483647&v=beta&t=uu-v3Wv8B56hQBJAD5VjRRV3DN-EoRbg-UMe2X3kaSk"
    ],
    "videoUrl": null,
    "videoPosterUrl": null,
    "clickUrl": "https://www.hubspot.com/grow-europe?utm_source=linkedin&utm_medium=paid&utm_campaign=Marketing_Registrations_EN_EMEA_VARIOUS_GROW-Europe-2026_prospecting_cm1013_ProgramBudget_v1a&utm_id=805100113&hsa_acc=517582366&hsa_cam=805100113&hsa_grp=891556833&hsa_ad=1558773703&hsa_net=linkedin&hsa_ver=3",
    "messageSender": null,
    "callToAction": null,
    "firstShown": "2026-09-23",
    "lastShown": "2026-09-25",
    "totalImpressions": "5k-10k",
    "impressionsLow": 5000,
    "impressionsHigh": 10000,
    "impressionsByCountry": [
        { "country": "United Kingdom", "share": 91 },
        { "country": "Ireland", "share": 9 }
    ],
    "targeting": {
        "language": { "includes": ["English"], "excludes": [] },
        "location": { "includes": ["Ireland", "United Kingdom"], "excludes": [] },
        "parameters": [
            { "parameter": "Audience", "targeted": false, "excluded": true },
            { "parameter": "Demographic", "targeted": false, "excluded": false },
            { "parameter": "Company", "targeted": true, "excluded": true },
            { "parameter": "Education", "targeted": false, "excluded": false },
            { "parameter": "Job", "targeted": true, "excluded": false },
            { "parameter": "Member Interests and Traits", "targeted": false, "excluded": false }
        ]
    },
    "detailsRead": true,
    "search": "accountOwner \"HubSpot\"",
    "isNew": null,
    "charged": true,
    "reason": "ad with advertiser and content",
    "scrapedAt": "2026-09-25T12:12:10.512Z"
}
```

## Use from any MCP agent

```
https://mcp.apify.com/?tools=agnes.developer.queen/linkedin-ad-library-scraper
```

Ask the agent what a competitor is advertising on LinkedIn this month. It should read `text`, `headline`, `imageUrl` or `videoUrl`, `clickUrl`, and `totalImpressions` and `targeting` where present.

## Integrations

Call it once per row from Clay, n8n, Make or your own code. This returns the dataset in the same request.

```
POST https://api.apify.com/v2/acts/agnes.developer.queen~linkedin-ad-library-scraper/run-sync-get-dataset-items?token=YOUR_APIFY_TOKEN
Content-Type: application/json

{ "companies": ["HubSpot"], "maxAdsPerSearch": 20 }
```

It also works with `apify-client`, schedules and webhooks.

## Use cases

- **B2B marketing teams.** Pull every ad three competitors ran in Europe this month, with impressions and the countries they went to.
- **Agencies pitching LinkedIn ads.** Open the pitch with the prospect's own ads, their run dates and what they targeted.
- **Competitive intelligence.** Schedule monitor mode weekly on ten companies and get only the new ads.
- **Copywriters.** Build a swipe file of a category's ads from keyword searches, with the picture or video of each.
- **Sales teams.** Search a keyword in a country to find companies that advertise there, then see what they say.

## FAQ

### Does it return ad spend?

No. LinkedIn does not publish spend. You get the impressions range for ads shown in the EU.

### Why do some ads have no dates, impressions or targeting?

LinkedIn publishes those only for ads shown in the European Union. Ads shown elsewhere come with the advertiser, the payer and the ad itself. Set `countries` to EU codes to get ads that carry them.

### Why was an ad delivered free?

LinkedIn showed no text, picture or video for it. The `reason` field says so, and `adUrl` still opens it.

### Do I need a LinkedIn account or cookies?

No. The Actor reads the public Ad Library.

### Can I filter by impressions?

Yes, with `minImpressions` and `maxImpressions`. LinkedIn applies the filter to EU-shown ads, so ads without published impressions are dropped.

### How often should I run monitor mode?

Weekly is enough for most advertisers. Daily suits companies that launch campaigns often. Each run charges only for new ads.
