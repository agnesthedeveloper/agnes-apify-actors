# Build notes, LinkedIn Ad Library Scraper

Actor `agnes.developer.queen/linkedin-ad-library-scraper` (id `A88xKG4P7lNb9mevu`). Private. Priced on 2026-09-25 with `actor-start` at $0.00005 and `ad` at $0.003 (one record with id, advertiser and content).

## Why this actor

Actor 4 scan on 2026-09-25 (scratchpad `actor4-scan-2026-09-25.md`). The LinkedIn Ad Library needs no login, is public by design, and the band's existing actors are thin. Measured cost is about $0.0005 per ad against a $0.003 price. The other candidates fell out: the tech-stack river has one bulk user, keyword research needs DataForSEO, and the Meta Ad Library blocks headless traffic.

## Source

`linkedin.com/ad-library/search` in Playwright Chromium on Apify residential proxy, 4 GB. The first page is a normal navigation; later pages come from `searchPaginationFragment`, fetched inside the page so the session cookies travel with it. Detail pages are read per ad unless `withDetails` is false.

## Measured runs

| Run | Build | Input | Rows | Charged | With EU dates | Rotations | Usage |
|---|---|---|---|---|---|---|---|
| `rSPLHh4Hwa2k6fjXF` | 0.1.1 | HubSpot, 10 ads | 10 | 10 | 9 | 0 | $0.0012, 44 s |
| `QvkgsQNp7K7zLDFfB` | 0.1.1 | keyword "webinar", DE, 30 ads | 24 | 24 | | | stopped at the pagination wall |
| `c8uKrQJzYoTGo0BVy` | 0.1.1 | keyword "crm", US, 30 ads, no details | 30 | 30 | 0 | 0 | |
| `AmL3sxDqajREV421R` | 0.1.2 | HubSpot, 40 ads, details | 40 | 40 | 28 | 5 | $0.0304, 117 s |

Cost per charged ad on 0.1.2 is $0.00076 at 4 GB (compute $0.026, residential proxy $0.004). Margin at $0.003 is about 75%.

## The pagination wall

The fragment endpoint answers HTTP 429 after about 24 detail pages on one session. The pagination token belongs to the search, not the session, so build 0.1.2 opens a new browser context, reloads the search once, and continues with the same token. The 40-ad run crossed the wall five times without a search failure.

## Input notes

- `countries` takes ISO two-letter codes. `EU` is not a code: LinkedIn returns zero matches for it and the run charges only the start. The schema accepts any two letters, so the README should say "ISO codes, not EU" before publishing.
- Run dates, impressions and targeting exist only for ads shown in the European Union. A HubSpot run without a country filter returned 28 of 40 with them.

## Field fill on the 40-ad run

advertiserName, payer, adFormat, creativeType and text on 40 of 40; imageUrl 38; headline 28; firstShown, lastShown, totalImpressions, targeting and impressionsByCountry 28; videoUrl 2. Formats: 37 single image, 2 video, 1 document.

## State

Build 0.1.3 is `latest` (0.1.2 plus the country-code wording in the schema and README). Repo committed locally, no remote. **Published 2026-09-25** (`isPublic: true` PUT on the slug URL with title, description, seoTitle, seoDescription and categories, on the owner's go).

Listing, set 2026-09-25 by API while private: seoTitle `LinkedIn Ad Library Scraper, Company Ads and Targeting` (54), seoDescription 151 characters, categories `MARKETING`, `SOCIAL_MEDIA`. Icon: Grok CLI engraving (framed cards on a shelf under a magnifying glass), 1-bit, 34.5% black, 38 KB, uploaded through the Console with `.icon-gen/upload-icon.mjs` and confirmed by `pictureUrl`. Note: the Console's Display information Save overwrote `categories` to `SOCIAL_MEDIA` only, so the listing PUT was repeated after the icon upload. Do the icon first, the listing PUT second.

Left: GitHub remote. The gh login on this Mac is `the-ai-entrepreneur-ai-hub`, not Agnes; the owner is adding `agnesthedeveloper` as a second gh account and SSH host alias without removing the first. The two sibling actors are still private and have no remote either. After publish: record the Store rank on "linkedin ad library" at day 14 and day 30 per the plan.

## Store rank baseline

- 2026-09-25, day 0: public, PAY_PER_EVENT, agentic payments on, categories MARKETING + SOCIAL_MEDIA. Rank 32 of 47 returned on "linkedin ad library". Re-check day 14 and day 30.
