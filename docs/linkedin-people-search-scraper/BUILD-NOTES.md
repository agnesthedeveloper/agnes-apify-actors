# Build notes, LinkedIn People Search Scraper

Actor `agnes.developer.queen/linkedin-people-search-scraper` (id `a1QIzTqrpWq63yAoe`). Private. Priced on 2026-09-24 with `actor-start` at $0.00005 and `matched-profile` at $0.02 (one record).

## Why this actor

Live Store scan on 2026-09-23. The buyer phrase "linkedin people search" has 1,320 monthly users across the top five, and
the first actor in raw Store order (neuralverge) has no reviews. The actor with the most users there, memo23, has 866
monthly users and 2 reviews rated 5. It is the same buyer (outbound agencies) as the flagship that earned 78% of the 72-actor
book's paying revenue.

## Source

Google through Apify's GOOGLE_SERP proxy, parsed with the flagship's 2026-09-19 parser (`src/parsers.js`, gbv=1 basic
layout plus the link-less fallback). Bing served unrelated results to a plain client. DuckDuckGo answered with a bot
challenge. Neither is a usable fallback.

## Measured runs

| Run | Build | Query | Rows | With link | Billable, final bar | Search fetches | Usage |
|---|---|---|---|---|---|---|---|
| `kZ1rb8xUm0Kab4DyP` | 0.1.1 | broad, 20 companies x 6 titles | 400 | 339 | 44 (13.0%) | 102 | $0.556 at 4 GB, about $0.31 at 512 MB |
| `TE95paJAJKswYgWCe` | 0.1.2 | phrase ("CFO at Stripe"), aborted | 180 | 180 | 33 (18.3%) | 121 | $0.330 at 512 MB |
| `8bsM7hSIXjJSIoNry` | 0.1.3 | broad, prefill (Stripe) | 10 | 10 | 4 | 5 | $0.019, 203 s |
| `bPcR2r1uaaGZDM1ZB` | 0.1.5 | broad, prefill (Stripe, 10 max) | 10 | 10 | 3 | 2 | $0.006, 16 s |

Cost per billable row. Broad query about $0.0068 at 512 MB (estimated from the 4 GB run), phrase query $0.0100. Broad is kept.

## Against the plan's pass bars

| Bar | Result |
|---|---|
| Billable yield at least 40% | Fail. 13 to 18%. Google x-ray returns many people who show the title elsewhere on their page. |
| 0 wrong rows in 30 hand-checked | Fail on build 0.1.1 (7 of 30), pass after the fixes (0 of 33 on the verdict run). |
| Search cost per billed row at most $0.004 | Fail at $0.01 per match. About $0.0068. |

At $0.01 per matched profile the creator share ($0.008) barely covers cost. The owner chose $0.02 per matched profile
on 2026-09-24, which leaves about $0.016 per match against $0.0068 of cost.

## Charge bar fixes from the 2026-09-23 audit

Every fix has a test in `test/charge-bar.test.mjs` built from the headline that exposed it, with some company names swapped.

- Title and company must sit in the same clause of the headline ("CMO @ G2 || Advisor || Zoom" is G2's CMO).
- The company must stand alone ("Linear" is not "Linear Controls", "Zoom" is not "Zoom Media").
- The first "at X" or "@ X" after the title names the employer ("CTO/Co-Founder @ Ode with <Company>").
- Former, support and field roles never bill ("X CTO", "Partner to CTO", "Field CTO", "Customer CTO").
- Acronyms match long forms (CFO and Chief Financial Officer).

## Review fixes, 2026-09-23 (fresh-context review)

- A charge that used the last of the buyer's budget was taken and the row dropped. The row is now written and the run stops.
- The employer must sit in an employer position for the title. "Investor in Stripe, CFO" and "Board Member, Stripe - CFO, Acme" no longer bill.
- A company name Google cut off with "..." does not bill. "CFO | Stripe", "Stripe CFO" and "CEO & Co-Founder at Stripe" now bill.
- Punctuated names bill (AT&T, Macy's, Booking.com), and "Stripe, Inc." as input matches "CFO at Stripe".
- Companies with no Latin letters are kept and never confirmed, instead of turning the run into a title-only search.
- Every row is judged against all input titles and companies. maxResults cannot be overshot by parallel pages.
- Paid mode starts only when the exact events are priced.

## Second review fixes, 2026-09-23

- Support markers anywhere before the title stop billing ("Executive Assistant to the Founder & CEO", "Chief of Staff for the CEO", "Hiring: CFO").
- Past markers anywhere before the title or right after it stop billing ("Former Google CFO", "CFO - Retired", "CFO at Stripe (2018-2021)", "CFO and former VP Finance").
- "CFO, AT&T" bills. Company names with any non-Latin letter are never confirmed ("Яндекс Cloud" cannot match "Cloud CTO").
- Re-scored on the real 0.1.1 rows, 44 of 339 linked rows bill. Every row that changed is a wrong or a conservative case.

## Priced runs, 2026-09-24

| Run | Input | Rows | Rows with `charged: true` | Platform charged events | Usage |
|---|---|---|---|---|---|
| `fHFSRICy0YlZllKnj` | CEO and CFO at Stripe and Asana, 20 max | 20 | 6 | `matched-profile` 6, `actor-start` 1 | $0.0092 |
| `8gLUTkFFfNYnNg6IS` | prefill, VP of Sales and Head of Sales at Stripe, 10 max | 10 | 0 | `matched-profile` 0, `actor-start` 1 | $0.0183 |

- The platform's counts lagged the finished run by about a minute, then matched the dataset exactly. Owner runs are not
  billed (`accountedChargedEventCounts` stays 0). Usage also settles after the run ends, so these are the final values
  read 10 minutes later. Most of it is the search proxy, $0.0025 per Google page.
- The prefill run got 8 fetches for the first page: 6 pages without profile links and 2 timeouts. All 10 rows came
  free from the link-less fallback. This is the one search in ten that does not recover (see Known limits).
- Four of the six billed rows in the CEO run are strangers whose own headline says CEO of Stripe or Asana, judged
  against the companies' public leadership. Patrick Collison, Stripe's known CEO, is the fifth. The sixth says CFO of
  Asana and was not checked. The bar reads headlines only, so it bills all six.

## Known limits

- Headlines are self-reported. Seven different profiles described themselves as "CTO at Netflix".
- Most Google pages hide profile links. The first page gets up to eight fetches (about nine in ten recover), later pages five.

## Still to do before publish

- Done 2026-09-24. Identity verified and a payout method set in Agnes's Console. Pricing written while private, one
  record, and the event keys match the code (any other key would run free). The README output record is a
  `charged: true` row from run `fHFSRICy0YlZllKnj`.
- Owner. Rotate the Agnes API token. The old one, stored in plain text in an old session file, still worked on 2026-09-24.
- Done 2026-09-24. Icon. `icon.png` in this folder, 1024 px, one bit, 24.9% black, no text. Uploaded in the Console
  (Publishing, Display information) and confirmed by `pictureUrl` on the API, which appears only once an icon is saved.
  The save takes about 6 seconds, and closing the page sooner leaves it as an unsaved draft.
- Owner go. `isPublic`.

## Price change, 2026-09-25

Second pricing record, from 07:14 UTC: `matched-profile` $0.02 -> **$0.015**, `actor-start` $0.00005 -> **$0.005**.
Set with `newSav/.publish/change-pricing.sh people 0.015 --start 0.005 --apply` while the actor was private with no
paying users, so it took effect at once. Reason: a Store scan of 32 rivals with 50 or more monthly users put the median
per-row price at $5 per 1,000 and the 75th percentile at $10; only two enrichment products charge $20. $15 sits above
every per-row rival and under those two. The start fee matches memo23, the phrase leader, and covers the $0.005 to
$0.02 of Google pages a zero-match run burns. Measured cost per match stays about $0.0068.

## Published

2026-09-25 16:12 UTC: `isPublic` true on the owner's go, build 0.1.10, `actor-start` $0.005 + `matched-profile` $0.015. Listing PUT: seoTitle "LinkedIn People Search Scraper by Title, Company, Location", seoDescription 159 characters, categories LEAD_GENERATION + SOCIAL_MEDIA. A single PUT carrying isPublic, description, seoDescription and categories together failed silently; seoTitle + categories + isPublic in one PUT and seoDescription in a second both landed.

Store rank baseline, day 0: 17 of 44 returned on "linkedin people search". Re-check day 14 (2026-10-09) and day 30 (2026-10-25). Open quality question still stands: headline-only matching passed 4 strangers as CEO of Stripe/Asana in the priced run.
