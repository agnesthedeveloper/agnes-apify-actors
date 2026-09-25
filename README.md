# Apify Actors by Agnes Maina

I publish Apify Actors for outbound and go to market teams. Each one returns people or company data with a charge bar, so you pay for confirmed rows and every other row is delivered free.

| Actor | What it does | Run it |
|---|---|---|
| [LinkedIn New Hires Finder](linkedin-new-hires-finder.md) | LinkedIn New Hires Finder is an Apify Actor that takes a company website, name, or LinkedIn URL and returns decision makers who started at that company recently, with the month they started and the company they left, only when the current-employer match clears the bar. | [Apify Store](https://apify.com/agnes.developer.queen/linkedin-new-hires-finder) |
| [LinkedIn People Search Scraper](linkedin-people-search-scraper.md) | LinkedIn People Search Scraper is an Apify Actor that finds public LinkedIn profiles by job title, company and location, and charges only for people whose own headline confirms the title and the company you searched. | [Apify Store](https://apify.com/agnes.developer.queen/linkedin-people-search-scraper) |
| [Google Ads Transparency Scraper](google-ads-transparency-scraper.md) | Google Ads Transparency Scraper is an Apify Actor that pulls the ads a company runs on Google from the Ads Transparency Center, by website domain or advertiser name, and returns the ad itself, its first and last shown dates, and the countries where it ran. | [Apify Store](https://apify.com/agnes.developer.queen/google-ads-transparency-scraper) |

## How the charge bar works

A run emits every row it finds. Rows that clear the bar for that Actor are marked `charged: true` and billed at the listed event price. Rows that do not clear it are still written to the dataset and cost nothing. The bar for each Actor is described on its page.

## Contact

Apify profile at https://apify.com/agnes.developer.queen. Issues with any Actor go to its Issues tab on the Apify page.
