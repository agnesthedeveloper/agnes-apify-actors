# LinkedIn Jobs Scraper: build and launch record

September 27, 2026. Actor `agnes.developer.queen/linkedin-jobs-scraper`, ID `TXzPBmagxRli2yfhX`. Source code is hidden; the Actor uses limited permissions.

Published September 27, 2026 after all gates passed. The final documentation builds preserve the tested runtime code. Store: https://apify.com/agnes.developer.queen/linkedin-jobs-scraper

## Launch checks

- 10 regression tests passed, including the installed Apify SDK billing path, exact spending limits, malformed HTML, identity mismatch, pagination, filters, monitoring and restart recovery.
- Benchmark build **0.1.4**: 20 searches across the US, UK, Canada, Germany and Australia; software engineer, accountant, sales manager and registered nurse queries; 25 delivered jobs each.
- **500 jobs from 506 detail attempts (98.81%)**. Six incomplete detail responses were skipped and not charged. All searches reached the requested cap; affected runs disclose partial source coverage.
- Independently re-fetched 50 distinct jobs across the benchmark, compared source identity/title/company, and reviewed the resulting records and description excerpts: **50/50 matched**, no identity mismatches.
- Platform job-event counts matched dataset rows across **37 runs**, including the first two failed smoke runs, which each delivered and billed exactly one job before stopping.
- Datacenter benchmark cost: **$0.017479**, or **$0.00003496 per delivered job**. Launch ceiling: $0.0004. These are observed test costs, not a scale guarantee.
- Recorded run cost **$0.026624** plus build cost **$0.004362**, before the final documentation build. Owner authorized up to $10 even if billed.
- Cloud monitor runs `opIMgRKt6mJt3bhDW` and `1dObelAb2LHAHAuH9` delivered different jobs, billed one each and preserved the capped job for the next run. Named storage worked under limited permissions.
- Exact-budget run `pFvXOC1WZRyJzHoXg` delivered and billed two jobs at a $0.00405 limit (two jobs plus start), then stopped successfully.

## Implementation choices

Use Node 22, Apify SDK 3.7.2, Cheerio and got-scraping, with a locked dependency tree. HTTP collection and ordered delivery; no browser or external data-provider subscription. Direct cloud requests hit rate limits in the wider trial, so Apify datacenter proxy is the default. Residential is optional and more expensive.

A `job` custom event is $0.002 and `apify-actor-start` is $0.00005 per GB, minimum one event. No synthetic dataset charge or usage surcharge. `Actor.pushData(row, 'job')` writes before charging. A pre-check prevents the SDK's extra-over-limit write path. The SDK's aggregate `chargedCount` includes its unpriced synthetic dataset bookkeeping event; the application instead checks the change in the specific `job` event count. A real-SDK regression test covers this.

The first build was rejected for an unsupported integer enum in Apify's form schema; runtime validation still restricts posting age to 1, 7 or 30. The first two cloud smoke runs exposed the aggregate-count issue above; it was corrected before the benchmark.

Only delivered IDs enter the 90-day monitor history. Restart recovery first reads the run's existing dataset. Use one non-overlapping schedule per configuration; simultaneous runs on the same monitor are unsupported. An uncertain storage or billing error fails closed; inspect/resume that run rather than blindly launching another.

## Benchmark runs

| Search | Run ID | Jobs | Detail success/attempts | Platform cost |
| --- | --- | ---: | ---: | ---: |
| australia-accountant | `jP2jCkf3xgJrpwuKt` | 25 | 25/26 | $0.000819 |
| australia-registered-nurse | `QySZkMmr6DVFrKIrz` | 25 | 25/25 | $0.000902 |
| australia-sales-manager | `k4cdDTXZAdeKrpXgW` | 25 | 25/26 | $0.001534 |
| australia-software-engineer | `cBcMGKUUfhAxrhSex` | 25 | 25/25 | $0.001194 |
| canada-accountant | `If9ByWAN2nxqvDPHs` | 25 | 25/25 | $0.000859 |
| canada-registered-nurse | `4DqlrDWBtVpDs7CO0` | 25 | 25/25 | $0.000788 |
| canada-sales-manager | `wPK9CX0dNBFx5OSCj` | 25 | 25/25 | $0.000686 |
| canada-software-engineer | `ZkvfOVjJNwApvU6X8` | 25 | 25/25 | $0.000729 |
| germany-accountant | `tvnFdyhce636DDwhh` | 25 | 25/25 | $0.000856 |
| germany-registered-nurse | `XEV0hMpnnhYve4F0M` | 25 | 25/26 | $0.000883 |
| germany-sales-manager | `FQWJAvMrXEjmWQt67` | 25 | 25/25 | $0.000827 |
| germany-software-engineer | `YyxnPUFkp1TZqUvcy` | 25 | 25/25 | $0.000862 |
| united-kingdom-accountant | `E3d75hUhnpiLiNi5L` | 25 | 25/25 | $0.000821 |
| united-kingdom-registered-nurse | `885CQbHubnT6e87TB` | 25 | 25/25 | $0.000673 |
| united-kingdom-sales-manager | `yRfe1axpQzJPiY2kk` | 25 | 25/25 | $0.000730 |
| united-kingdom-software-engineer | `EkUc71IYKW0qEUBEK` | 25 | 25/25 | $0.000781 |
| united-states-accountant | `e0sNieie8DiPnaY7r` | 25 | 25/25 | $0.000805 |
| united-states-registered-nurse | `3cig7LwkcW37BqWRr` | 25 | 25/28 | $0.000928 |
| united-states-sales-manager | `o79uA6h06AtcPBaB6` | 25 | 25/25 | $0.001014 |
| united-states-software-engineer | `IEviwGyOleI1iBiDA` | 25 | 25/25 | $0.000789 |

Local raw evidence is under `artifacts/` (excluded from source uploads and git): run records, datasets, summaries, the independent identity sample, source HTML and `launch-report.json`. `scripts/verify_launch.py` refreshes charges and evaluates the numerical gates before publication.

## Revenue measurement

The owner confirmed the target is **$5,000 monthly account revenue by November 2026**, using Apify Store discovery only. Existing account revenue remains unverified; owner test runs are not customer revenue. This launch demonstrates extraction and billing, not buyer demand for this particular listing.

At $2 per 1,000 jobs, this actor alone needs 2.5 million paid jobs per month to produce $5,000 gross revenue. Each week record external paying customers, repeat spend, revenue, platform cost, failures and Store discovery. Evaluate actual monthly revenue separately from run-rate. If there is no external paid usage by October 31, revisit positioning before adding features.

## Dependency note

`npm audit` reports one moderate `stream-json` advisory inherited through Crawlee/Apify, displayed as three affected packages. The suggested automatic fix would downgrade Apify across major versions; it was not applied. This actor parses source HTML with Cheerio and accepts bounded, flat search inputs. Revisit when the upstream dependency provides a compatible fix.
