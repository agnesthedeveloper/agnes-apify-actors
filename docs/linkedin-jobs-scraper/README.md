# LinkedIn Jobs Scraper — Full Descriptions & New Jobs Monitor

Collect public LinkedIn job postings with full descriptions, company, location and published dates. Use literal title filters and a recurring feed that suppresses jobs already delivered to you.

In the September 27, 2026 cloud benchmark, 20 searches across five countries delivered 500 jobs from 506 attempted detail pages. All 50 independently checked job identities matched. These are measured results, not a guarantee of exhaustive LinkedIn coverage.

## Quick start

```json
{
  "keywords": "software engineer",
  "location": "United States",
  "titleIncludes": ["engineer"],
  "titleExcludes": ["intern"],
  "maxJobs": 100
}
```

Alternatively supply `searchUrls`, an array of up to 20 LinkedIn `/jobs/search` URLs. Do not combine URLs with `keywords`, `location`, `companyIds` or `postedWithinDays`. Duplicate input modes and unsupported URL filters produce an actionable error before scraping.

Results are sorted newest first. `maxJobs` is the total cap across all searches, default 100, maximum 10,000. Each search scans at most 1,000 source candidates or 100 pages. LinkedIn can return fewer results, repeat pages, or limit access; this actor does not promise exhaustive coverage.

## Pricing

The active price is **$2 per 1,000 complete jobs**, plus **$0.00005 per start at up to 1 GB memory**. There is no additional platform-usage surcharge.

One `job` event is charged only when a record with a confirmed job ID, title, company identity, canonical URL and a description of at least 100 characters is delivered. Full descriptions are included. Incomplete records, duplicates and title-filter failures are skipped and never billed as jobs. Errors are in `DIAGNOSTICS`, outside the job dataset.

## Filters and output

`titleIncludes` requires at least one case-insensitive literal substring; `titleExcludes` rejects any matching substring. Both are checked against the detail-page title before delivery. `companyIds` accepts numeric IDs. `postedWithinDays` accepts 1, 7 or 30. Company, location and posting-age parameters are sent to LinkedIn; the source controls those filters, and geographic boundaries are not independently verified.

Each row has `jobId`, `url`, `title`, `companyName`, `companyUrl`, `location`, `descriptionText` and `scrapedAt`. Additional published fields include salary text, seniority, employment type, job function, industries and the job poster's name/profile URL. Missing optional values are null. No emails, inferred hiring managers, inferred salary, or inferred applicant counts.

`postedAtRaw` preserves the displayed date text. `postedAt` is a source date (`YYYY-MM-DD`) when present or an approximate timestamp derived from relative text. `postedAtPrecision` is `day`, `approximate` or null. `postedAtEstimated` distinguishes estimates; an approximate date is not an exact publication timestamp. Visibility does not establish that a vacancy remains open.

## Measured output example

This real record comes from the September 27, 2026 cloud benchmark. The example omits `descriptionText` for brevity; the delivered row includes the full text. Availability can change after collection.

```json
{
  "jobId": "4419969671",
  "url": "https://www.linkedin.com/jobs/view/4419969671/",
  "title": "Senior Software Engineer \u2013 Go (Golang)",
  "companyName": "General Motors",
  "companyUrl": "https://www.linkedin.com/company/general-motors/",
  "location": "Warren, MI",
  "postedAtRaw": "2 weeks ago",
  "postedAt": "2026-09-12",
  "postedAtPrecision": "day",
  "postedAtEstimated": false,
  "employmentType": "Full-time",
  "seniorityLevel": "Not Applicable",
  "scrapedAt": "2026-09-27T15:31:19.157Z"
}
```

## Daily new-job feed

Save this input as an Apify task and schedule it once per day:

```json
{
  "keywords": "software engineer",
  "location": "United States",
  "postedWithinDays": 1,
  "titleIncludes": [
    "engineer"
  ],
  "titleExcludes": [
    "intern"
  ],
  "maxJobs": 100,
  "onlyNew": true
}
```

 Enable `onlyNew` to suppress job IDs delivered under the same search and title-filter configuration within 90 days. The first run delivers matching jobs up to the cap; capped or failed jobs are not marked seen. A different cap uses the same history; different searches or title filters use separate histories.

History lives in your named key-value store `linkedin-jobs-monitor-v1`. The actor creates this storage under limited permissions and retains access on subsequent runs. Run only one task at a time per configuration: overlapping runs are not supported and can duplicate output or overwrite monitor state. Configure your account's storage retention to preserve this named store for the desired monitoring period; deleting it resets the baseline. No closure or repost inference is made from missing results.

On a resumed run, the actor reads its existing dataset IDs before processing. After an uncertain storage/billing error, inspect the run and resume the same run instead of starting another. A new non-monitor run intentionally collects and charges for its own results again.

## Reliability

`RUN_SUMMARY` reports extracted jobs, request counts, parse failures and the stopping reason for each search. A source failure is distinguished from a recognized empty page. Partial runs are labeled explicitly. A run with no delivered jobs and source/parser errors fails instead of appearing as an empty success.

`proxyConfiguration` selects direct, datacenter or residential access. Retries are bounded at three requests. Apify datacenter proxy is the default after direct requests encountered rate limits in the cloud benchmark. No browser, login cookie or third-party data API is required. Benchmark the selected proxy's reliability and cost on your searches; no mode is guaranteed to bypass blocking.

## API and integrations

Use `agnes.developer.queen/linkedin-jobs-scraper` from the Apify API, client libraries, MCP, schedules or webhooks. Export the default dataset as JSON or CSV. Keep API tokens in your environment or credential manager.

## Support

Use this Actor's Issues tab to report problems. Include the run ID and describe the expected output.
