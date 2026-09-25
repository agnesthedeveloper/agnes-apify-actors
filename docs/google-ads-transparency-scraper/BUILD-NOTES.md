# Build notes, Google Ads Transparency Scraper

Actor `agnes.developer.queen/google-ads-transparency-scraper` (id `IP7uDwXTigSf8Fz6o`). Private. Priced on 2026-09-24 with `actor-start` at $0.00005 and `ad` at $0.003 (one record).

## Why this actor

Live Store scan on 2026-09-23. The buyer phrase "google ads transparency" has 1,362 monthly users across the top five.
solidcode, first in raw Store order, has 522 monthly users and a 1.93 rating despite 99.99% run success. scrapesage,
second in raw order, has more users (619). Neither returns ad copy or times-shown ranges. Both return preview links
for text and video ads.

## Source

The Transparency Center's public RPC at `adstransparency.google.com/anji/_/rpc`.

| Call | Use |
|---|---|
| `SearchService/SearchCreatives` | 40 ads per page. Next-page token in response field 2, sent back as request field 4 |
| `SearchService/SearchSuggestions` | Advertiser name to advertiser IDs |
| `LookupService/GetCreativeById` | Per-country dates and times-shown ranges (field 17), variations (field 5) |

After roughly 250 calls from one IP, Google answers with a 302 to google.com/sorry. On Apify the datacenter pool hit
the same limit (25 rotations for 15 ads, one run got no page), so the RPC goes through residential proxy. Measured on
the residential runs, a detail call is about 8 KB and a search page about 24 KB. Previews (130 to 200 KB) come from
googleusercontent.com on datacenter proxy.

## What decodes

| Format | What the actor returns |
|---|---|
| Text, about 11% | Headline, description, display URL and sitelinks from the preview's `ad=` record, in two layouts |
| Text, about 89% | Google publishes these only as rendered pictures. The actor returns the picture of every variation |
| Image | The creative, from the search record |
| Shopping | Product title, product photo and merchant from the preview's `pla=` record |
| Video | YouTube link from the preview when Google embeds one |
| Rich display | Nothing decodable. Delivered free with the preview link |

## Measured runs (512 MB unless noted)

| Run | Build | Input | Rows | With content | Usage |
|---|---|---|---|---|---|
| `oqc596imJPVC5efm6` | 0.1.1 | 20 domains x 10, 4 GB, datacenter | 200 | 197 | $0.0705 |
| `aIYc5Edroiv7RP5db` | 0.1.2 | 20 domains x 10, datacenter | 190 | 187 | $0.0052 |
| `kDizSEze3lFOyUc7m` | 0.1.2 | nike.com in DE, datacenter | 20 | 18, all 20 list DE | $0.0011 |
| `b8GU9rbPv5xz7hdqI` | 0.1.3 | 20 domains x 10, datacenter | 200 | 197 | $0.0049 |
| `LkucnaqkyZJnujcUV` | 0.1.5 | nike.com x 20, residential RPC | 20 | 18 | $0.0035 |
| `QJCurFpSCzTeClwNe` | 0.1.5 | gymshark.com monitor, residential RPC | 15 | 15 | $0.0034 |
| `9xKkNGZVkvqVLKvJv` | 0.1.6 | gymshark.com monitor, second run | 0 | 0 | $0.0006 |
| `9hh9W7xbQ0gsA0aJH` | 0.1.8 | HubSpot by domain x2, name and ID | 25 | 25, 13 duplicates skipped | $0.0049 |
| `Pdf0rcxy4DCdJCwfz` | 0.1.9 | nike.com x 20, priced (prefill) | 20 | 19, all 19 charged | $0.0048 |

On the priced run the platform recorded 19 `ad` events for the 19 rows marked `charged: true`, about a minute after the
run finished. Owner runs are not billed. Usage also settles after a run ends, so every figure in the table is the
final value, re-read on 2026-09-24.

With the shipped residential RPC, cost is about $0.0002 per ad, against a creator share of $0.0024 at $0.003 per ad.

## Fixes found by these runs

- Text ads were labeled image ads because their search record carries Google's rendered picture (build 0.1.1).
- Text ads without a preview in the search record take the variation from the detail record (build 0.1.3).
- Most text ads have no text form at all, so the event is "Ad", not "Decoded ad", and the README says so.
- Monitor mode remembered only delivered ads, so a second run returned older ads as new (build 0.1.4).

## Review fixes, 2026-09-23 (fresh-context review)

- A charge that used the last of the buyer's budget was taken and the row dropped. The row is now written and the run stops.
- Repeated domains ("nike.com" and "https://www.nike.com/") and ads returned by both a domain and a name were charged twice. Targets and ads are now de-duplicated per run.
- Advertiser names matched by substring ("nike" also took "nikey", "Nikena"). Names now match exactly, apart from legal suffixes, tested on captured suggestions.
- A failed name lookup crashed the run after the start fee. It now logs and continues.
- Monitor mode lost new ads past the cap on later runs. Only the first run baselines whole pages.
- A country filter let through ads with no country data. They are now dropped.
- Paid mode starts only when the exact events are priced.

## Second review fixes, 2026-09-23

- With a country filter, an ad whose detail call failed was marked seen in monitor mode and lost. It is now skipped without being remembered.
- A name takes the largest exact-name advertiser and same-name accounts in its country ("Nike" takes Nike, Inc. and lists the Italian and Kenyan "Nike" accounts in the log with their IDs).

## Still to do before publish

- Done 2026-09-24. Identity verified and a payout method set in Agnes's Console. Pricing written while private, one
  record, and the event keys match the code (any other key would run free). The README output record is a
  `charged: true` row from run `Pdf0rcxy4DCdJCwfz`.
- Owner. Rotate the Agnes API token. The old one, stored in plain text in an old session file, still worked on 2026-09-24.
- Done 2026-09-24. Icon. `icon.png` in this folder, 1024 px, a glossy 3D render of Google's G on white, the owner's
  choice on 2026-09-24 over the one-bit engraving. It is Google's trademark, so Google or Apify may ask for a change. Uploaded in the Console
  (Publishing, Display information) and confirmed by `pictureUrl` on the API, which appears only once an icon is saved.
  The save takes about 6 seconds, and closing the page sooner leaves it as an unsaved draft.
- Owner go. `isPublic`.

## Price change, 2026-09-25

Second pricing record, from 07:17 UTC: `ad` $0.003 -> **$0.0025**, `actor-start` unchanged at $0.00005. Set with
`newSav/.publish/change-pricing.sh ads 0.0025 --apply` while private with no paying users, so it took effect at once.
Reason: the Store median for "google ads transparency" is $1.50 per 1,000 ads; the flat leader charges $2 plus $3 for
detail, so $5 for what this actor ships in one event. $2.50 is 1.25x the leader's base and half its base plus detail.
Cost is about $0.0002 per ad.

## Published

2026-09-25 16:13 UTC: `isPublic` true on the owner's go, build 0.1.10, `actor-start` $0.00005 + `ad` $0.0025. Listing PUT: seoTitle "Google Ads Transparency Scraper, Competitor Ads and Dates", seoDescription 161 characters, categories MARKETING + LEAD_GENERATION. Sent as two PUTs (isPublic + seoTitle + categories, then seoDescription); the combined PUT with description and seoDescription in one body did not persist.

Store rank baseline, day 0: not in the top 50 on "google ads transparency" (47 returned). Re-check day 14 (2026-10-09) and day 30 (2026-10-25). If day 14 shows users but no payers, cut the price per the plan.
