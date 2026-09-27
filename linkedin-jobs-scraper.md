# LinkedIn Jobs Scraper

Collect public LinkedIn jobs with full descriptions, company, location and published dates. Apply title filters or schedule a feed that suppresses previously delivered jobs for 90 days.

**Price: $2 per 1,000 complete jobs**, plus $0.00005 per start at up to 1 GB. Incomplete jobs, duplicates and title-filter failures are not billed as jobs.

```json
{
  "keywords": "software engineer",
  "location": "United States",
  "titleIncludes": ["engineer"],
  "titleExcludes": ["intern"],
  "maxJobs": 100,
  "onlyNew": true
}
```

The September 27, 2026 cloud benchmark returned 500 complete jobs from 506 attempted details across 20 searches in five countries. Fifty independently re-fetched jobs matched their delivered identity, title and company. Source failures are reported separately; LinkedIn coverage and vacancy status are not guaranteed.

Apify datacenter proxy is included in event pricing. No LinkedIn login cookies or third-party data API key are needed. For monitoring, use one non-overlapping scheduled task per search/filter configuration. The actor uses limited permissions.

- [Run on Apify](https://apify.com/agnes.developer.queen/linkedin-jobs-scraper)
- [Full documentation](docs/linkedin-jobs-scraper/README.md)
- [Measured runs and launch checks](docs/linkedin-jobs-scraper/BUILD-NOTES.md)
- [Find people at hiring companies](linkedin-people-search-scraper.md)

The $5,000 monthly account-revenue target is a business goal, not a promised return from this Actor.
