# Google Ads Transparency Scraper

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

## Where to run it

The Actor runs on Apify at https://apify.com/agnes.developer.queen/google-ads-transparency-scraper. The page has the input form, the pricing and a free trial on the Apify free plan.
