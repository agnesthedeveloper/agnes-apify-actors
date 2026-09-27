# Apify Actors by Agnes Maina

I publish Apify Actors for outbound, marketing and recruiting teams. Each Actor documents exactly which delivered records are charged.

| Actor | What it does | Run it |
|---|---|---|
| [LinkedIn Jobs Scraper](linkedin-jobs-scraper.md) | Collect full job descriptions, company, location and published dates; filter titles and schedule feeds that suppress jobs already delivered. | [Apify Store](https://apify.com/agnes.developer.queen/linkedin-jobs-scraper) |
| [LinkedIn New Hires Finder](linkedin-new-hires-finder.md) | LinkedIn New Hires Finder is an Apify Actor that takes a company website, name, or LinkedIn URL and returns decision makers who started at that company recently, with the month they started and the company they left, only when the current-employer match clears the bar. | [Apify Store](https://apify.com/agnes.developer.queen/linkedin-new-hires-finder) |
| [LinkedIn People Search Scraper](linkedin-people-search-scraper.md) | LinkedIn People Search Scraper is an Apify Actor that finds public LinkedIn profiles by job title, company and location, and charges only for people whose own headline confirms the title and the company you searched. | [Apify Store](https://apify.com/agnes.developer.queen/linkedin-people-search-scraper) |
| [Google Ads Transparency Scraper](google-ads-transparency-scraper.md) | Google Ads Transparency Scraper is an Apify Actor that pulls the ads a company runs on Google from the Ads Transparency Center, by website domain or advertiser name, and returns the ad itself, its first and last shown dates, and the countries where it ran. | [Apify Store](https://apify.com/agnes.developer.queen/google-ads-transparency-scraper) |
| [LinkedIn Ad Library Scraper](linkedin-ad-library-scraper.md) | LinkedIn Ad Library Scraper is an Apify Actor that pulls the ads a company runs on LinkedIn from the public Ad Library, by company name, keyword or payer, and returns the ad itself, who paid for it, and, where LinkedIn publishes them, its run dates, impressions by country and targeting. | [Apify Store](https://apify.com/agnes.developer.queen/linkedin-ad-library-scraper) |

## Full documentation

The code for each Actor lives in a private repo. Its README and build notes are published here under [`docs/`](docs/), one folder per Actor: input fields, output schema, measured runs, costs and the pricing history. `sync-docs.sh` copies them in from the code repos.

## How the charge bar works

The people and advertising Actors mark billed rows with `charged: true` and deliver rows below their charge bar free. LinkedIn Jobs Scraper bills only complete, matching jobs and skips incomplete or duplicate records; its diagnostics are separate from the job dataset. Each Actor's page describes its charge bar.

## Contact

Apify profile at https://apify.com/agnes.developer.queen. Issues with any Actor go to its Issues tab on the Apify page.
