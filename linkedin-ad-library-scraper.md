# LinkedIn Ad Library Scraper

LinkedIn Ad Library Scraper is an Apify Actor that pulls the ads a company runs on LinkedIn from the public Ad Library, by company name, keyword or payer, and returns the ad itself, who paid for it, and, where LinkedIn publishes them, its run dates, impressions by country and targeting. No LinkedIn account or cookies.

## Pricing

| Event | Price | You pay when |
|---|---|---|
| Actor start | $0.00005 | once per run |
| Ad | $0.003 | an ad is delivered with its ID, its advertiser and its content (text, headline, picture or video) |

**That is $3 per 1,000 ads. Ads with no text, picture or video are delivered free, with their link.**

## What you get per ad

- The ad copy: headline, text, call to action and the picture or video LinkedIn published.
- The advertiser and the payer named in the Ad Library.
- Run dates, impressions by country and targeting, when LinkedIn shows them. LinkedIn publishes these for ads shown in the European Union, so use ISO country codes such as `DE` or `FR` in the `countries` input to get them; `EU` is not a code.

## Full documentation

- [README](docs/linkedin-ad-library-scraper/README.md): input fields, output schema, examples.
- [Build notes](docs/linkedin-ad-library-scraper/BUILD-NOTES.md): measured runs, costs and the pricing history.

Run it on the [Apify Store](https://apify.com/agnes.developer.queen/linkedin-ad-library-scraper).
