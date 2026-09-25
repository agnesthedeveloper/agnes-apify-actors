# Google Ads Transparency Scraper: competitor ads with copy, pictures, videos and dates

Google Ads Transparency Scraper is an Apify Actor that pulls the ads a company runs on Google from the Ads Transparency Center, by website domain or advertiser name, and returns the ad itself, its first and last shown dates, and the countries where it ran.

## Pricing

| Event | Price | You pay when |
|---|---|---|
| Actor start | $0.00005 | once per run |
| Ad | $0.0025 | an ad is delivered with its IDs, its shown dates and its content (text, picture or video) |

**That is $2.50 per 1,000 ads. Ads with no text, picture or video are delivered free, with their preview link.**

## The ad itself, not a preview link

Most Transparency Center scrapers return a preview link for text and video ads, so you open each one by hand to see it. This Actor returns the ad.

- Text ads give Google's rendered picture of every variation. When Google publishes the copy as text, you also get the headline, the description, the display URL and the sitelinks as text.
- Shopping ads give the product title, the product photo and the merchant.
- Video ads give the YouTube link when Google embeds one.
- Image ads give the image.

Every ad also comes with the countries where it ran, the first and last shown date in each country, and the times-shown range Google publishes for some countries.

```json
{
    "advertiserName": "Nike Retail BV",
    "format": "text",
    "adType": "search",
    "headline": "Nike Vomero",
    "description": "Discover Nike Shoes Online At Nike.com. Shop The Official Nike Site.",
    "displayUrl": "nike.com",
    "sitelinks": [],
    "firstShown": "2025-10-22",
    "lastShown": "2026-09-23",
    "daysShown": 337,
    "transparencyUrl": "https://adstransparency.google.com/advertiser/AR18378488041124659201/creative/CR06103840103250001921",
    "countries": [
        {
            "country": "CZ",
            "firstShown": "2025-10-22",
            "lastShown": "2026-09-23",
            "timesShownLow": 2000,
            "timesShownHigh": 3000
        },
        {
            "country": "DK",
            "firstShown": "2025-10-23",
            "lastShown": "2026-09-23",
            "timesShownLow": null,
            "timesShownHigh": 1000
        },
        {
            "country": "BE",
            "firstShown": "2025-10-22",
            "lastShown": "2026-09-22",
            "timesShownLow": null,
            "timesShownHigh": 1000
        }
    ]
}
```

## How it works

```
domains or advertiser names
            |
            v
Ads Transparency Center search, 40 ads per page
            |
            v
for each ad, read the per-country record and the pictures of every variation,
and decode the text where Google publishes it
            |
            +--> IDs, dates and content  -->  Ad (charged)
            |
            +--> no content              -->  delivered free with the preview link
```

## What data does it extract

| Field | What it is |
|---|---|
| `advertiserName`, `advertiserId` | The advertiser as Google verified it |
| `domain` | The advertiser's website |
| `creativeId` | The ad's ID in the Transparency Center |
| `format`, `adType` | text, image or video, and search when the text was decoded, shopping, image, video or text |
| `headline`, `description`, `displayUrl`, `sitelinks` | The ad copy, when Google publishes it as text |
| `imageUrl` | A picture of the ad when Google publishes one. The creative for image ads, Google's rendering for text ads, the product photo for shopping ads |
| `variations` | Google's rendered picture of each variation of the ad |
| `videoUrl` | YouTube link of a video ad when Google embeds one |
| `merchant` | Merchant name on shopping ads |
| `firstShown`, `lastShown`, `daysShown` | When the ad ran |
| `countries` | Each country with its first and last shown date and Google's times-shown range where published |
| `transparencyUrl`, `previewUrl` | Links to the ad in the Transparency Center |
| `isNew` | In monitor mode, true when the ad is new since your last run |
| `charged`, `reason` | Whether the row was charged, and why |

## What is NOT returned

- Ad spend or budgets. Google does not publish them.
- The copy of text ads as text when Google publishes it only as pictures. You get the pictures of every variation.
- Audience targeting, keywords or bids.
- Clicks, conversions or landing page performance.
- Times-shown ranges for countries where Google does not publish them.
- Ads Google has removed from the Transparency Center.
- Content of some rich display ads that only render inside Google's player. They are delivered free with the preview link.

## Quick start

1. Open the Actor and enter a competitor's website, for example `nike.com`.
2. Optionally choose a country and an ad format.
3. Run it and open the Ads table, or download JSON, CSV or Excel.

```json
{ "domains": ["nike.com"], "region": "anywhere", "format": "all", "maxAdsPerAdvertiser": 20 }
```

## Monitor mode

Set `onlyNewSinceLastRun` to true and schedule the run daily or weekly. The first run delivers current ads up to your limit and remembers every ad it saw. Each later run delivers only ads that appeared since, marked `isNew`, and you pay only for those.

## Input

```json
{
    "domains": ["nike.com", "adidas.com"],
    "advertisers": ["HubSpot"],
    "region": "US",
    "format": "text",
    "maxAdsPerAdvertiser": 100,
    "onlyNewSinceLastRun": false
}
```

| Field | Type | Default | Description |
|---|---|---|---|
| `domains` | array | | Advertiser websites, for example `nike.com` |
| `advertisers` | array | | Advertiser names exactly as Google verified them (Inc or LLC can be left off), or advertiser IDs that start with AR. When several advertisers share a name, the largest one and same-name accounts in its country are used, and the log lists the others with their IDs |
| `region` | string | `anywhere` | Two-letter country code. Only ads shown in that country are delivered |
| `format` | string | `all` | `all`, `text`, `image` or `video` |
| `maxAdsPerAdvertiser` | integer | 50 | Stop after this many ads per domain or advertiser, up to 1,000 |
| `onlyNewSinceLastRun` | boolean | false | Monitor mode, deliver only ads new since the last run of the same search |
| `proxyConfiguration` | object | Apify residential | Proxy for the small search calls. Ad previews always use datacenter proxy |

## Output

One full record from a real run.

```json
{
    "advertiserName": "Nike Retail BV",
    "advertiserId": "AR18378488041124659201",
    "domain": "nike.com",
    "creativeId": "CR17279215814825738241",
    "format": "text",
    "adType": "search",
    "headline": "Nike Basketball Shoes",
    "description": "Discover Nike Shoes Online At Nike.com. Shop The Official Nike Site.",
    "displayUrl": "nike.com",
    "sitelinks": [],
    "imageUrl": "https://tpc.googlesyndication.com/archive/simgad/10990147604733979610",
    "variations": [
        "https://tpc.googlesyndication.com/archive/simgad/10990147604733979610"
    ],
    "videoUrl": null,
    "merchant": null,
    "firstShown": "2025-10-24",
    "lastShown": "2026-09-23",
    "daysShown": 334,
    "countries": [
        {
            "country": "RO",
            "firstShown": "2025-11-04",
            "lastShown": "2026-09-18",
            "timesShownLow": null,
            "timesShownHigh": 1000
        },
        {
            "country": "CZ",
            "firstShown": "2025-11-03",
            "lastShown": "2026-09-22",
            "timesShownLow": null,
            "timesShownHigh": 1000
        },
        {
            "country": "DE",
            "firstShown": "2025-10-24",
            "lastShown": "2026-09-23",
            "timesShownLow": 6000,
            "timesShownHigh": 7000
        },
        {
            "country": "PL",
            "firstShown": "2025-10-24",
            "lastShown": "2026-09-22",
            "timesShownLow": null,
            "timesShownHigh": 1000
        },
        {
            "country": "NL",
            "firstShown": "2025-10-24",
            "lastShown": "2026-09-23",
            "timesShownLow": 50000,
            "timesShownHigh": 60000
        },
        {
            "country": "ES",
            "firstShown": "2025-10-26",
            "lastShown": "2026-09-20",
            "timesShownLow": null,
            "timesShownHigh": 1000
        },
        {
            "country": "IT",
            "firstShown": "2025-11-04",
            "lastShown": "2026-09-22",
            "timesShownLow": null,
            "timesShownHigh": 1000
        },
        {
            "country": "BE",
            "firstShown": "2025-10-25",
            "lastShown": "2026-09-23",
            "timesShownLow": 7000,
            "timesShownHigh": 8000
        },
        {
            "country": "FR",
            "firstShown": "2025-11-05",
            "lastShown": "2026-09-08",
            "timesShownLow": null,
            "timesShownHigh": 1000
        },
        {
            "country": "PT",
            "firstShown": "2025-11-11",
            "lastShown": "2026-09-10",
            "timesShownLow": null,
            "timesShownHigh": 1000
        },
        {
            "country": "HU",
            "firstShown": "2025-11-06",
            "lastShown": "2026-08-27",
            "timesShownLow": null,
            "timesShownHigh": 1000
        },
        {
            "country": "GR",
            "firstShown": "2025-11-05",
            "lastShown": "2026-09-02",
            "timesShownLow": null,
            "timesShownHigh": 1000
        },
        {
            "country": "SK",
            "firstShown": "2025-11-09",
            "lastShown": "2026-09-23",
            "timesShownLow": null,
            "timesShownHigh": 1000
        }
    ],
    "transparencyUrl": "https://adstransparency.google.com/advertiser/AR18378488041124659201/creative/CR17279215814825738241",
    "previewUrl": "https://displayads-formats.googleusercontent.com/ads/preview/content.js?client=ads-integrity-transparency&obfuscatedCustomerId=9151524834&creativeId=775607536946&uiFeatures=12&adGroupId=189588175887&versionId=13&assets=%3DH4sIAAAAAAAAAONS4OLkOHD7S-d5TgFmLk6Oe1cu_TrAIcDIxcHxc9GEHhUBRil2jmedq66eYZJi57g_v2fKIZDIg7tvzr0Dicy6BmUsvg9iAACwPMX6TwAAAA&allowedVariations=39&sig=ACiVB_xZXuuhte4blmgvxLxcf2grWspKbw&htmlParentId=fletch-render-15835437447088133956&responseCallback=fletchCallback15835437447088133956",
    "isNew": null,
    "charged": true,
    "reason": "ad with content and dates",
    "scrapedAt": "2026-09-23T22:44:30.181Z"
}
```

## Use from any MCP agent

```
https://mcp.apify.com/?tools=agnes.developer.queen/google-ads-transparency-scraper
```

Ask the agent for the text ads a competitor ran in a country this month. It should read `headline` and `description` where present, `variations`, `countries` and `lastShown`.

## Integrations

Call it once per row from Clay, n8n, Make or your own code. This returns the dataset in the same request.

```
POST https://api.apify.com/v2/acts/agnes.developer.queen~google-ads-transparency-scraper/run-sync-get-dataset-items?token=YOUR_APIFY_TOKEN
Content-Type: application/json

{ "domains": ["nike.com"], "maxAdsPerAdvertiser": 20 }
```

It also works with `apify-client`, schedules and webhooks.

## Use cases

- **Performance marketing agencies.** Pull every search ad a prospect's three rivals ran last month and open the pitch with their copy.
- **Competitive intelligence teams.** Schedule monitor mode weekly on ten competitors and get only the new ads.
- **Copywriters.** Build a swipe file of a category's ads, with the picture of every variation and the copy where Google publishes it as text, sorted by how long each ad has run.
- **Sales teams selling ad services.** Find companies that advertise on Google in a country and see what they say.

## FAQ

### Does it return ad spend?

No. Google does not publish spend in the Ads Transparency Center. You get the ads, their dates and countries, and Google's times-shown range where Google publishes one.

### Why was an ad delivered free?

Google published no text, picture or video for it, usually a rich display ad that only renders inside Google's player. The `reason` field says so, and the `previewUrl` still opens it.

### Why do some text ads have pictures but no headline?

Google publishes most text ads in the Transparency Center only as rendered pictures. The Actor returns the picture of every variation, and adds the text whenever Google publishes it as text.

### Why did an advertiser name return nothing?

Names must match the name Google verified, apart from Inc or LLC. The run log lists the names Google suggested. A website domain or an advertiser ID always works.

### Do I need a Google account or cookies?

No. The Actor reads the public Ads Transparency Center.

### Can I filter by country or format?

Yes. Set `region` to a two-letter country code and `format` to text, image or video. Ads that did not run in that country are not delivered.

### How often should I run monitor mode?

Weekly is enough for most advertisers. Daily suits advertisers that test new copy often. Each run charges only for new ads.
