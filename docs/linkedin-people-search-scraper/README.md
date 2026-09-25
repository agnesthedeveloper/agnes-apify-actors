# LinkedIn People Search Scraper: find people by job title and company (pay only for confirmed matches)

LinkedIn People Search Scraper is an Apify Actor that finds public LinkedIn profiles by job title, company and location, and charges only for people whose own headline confirms the title and the company you searched.

## Pricing

| Event | Price | You pay when |
|---|---|---|
| Actor start | $0.005 | once per run |
| Matched profile | $0.015 | a person's own headline confirms a title you searched, at the company you searched |

**That is $15 per 1,000 matched profiles. Every other row is delivered free.**

## You pay for matches, not for rows

A Google search for CFOs at a company also returns finance analysts, former CFOs, assistants and people at other companies with a similar name. Most people search tools bill every one of those rows. This Actor reads each person's own headline and bills only the rows that prove the match. The rest are still delivered, free, with the reason.

```json
[
    { "headline": "Chief Financial Officer, Asana", "matchedTitle": "CFO", "matchedCompany": "Asana", "charged": true, "reason": "title and current company confirmed in own headline" },
    { "headline": "Chief Financial Officer at Linear Controls", "matchedTitle": null, "charged": false, "reason": "current company not confirmed" },
    { "headline": "Executive Business Partner to CTO @ Vercel", "matchedTitle": null, "charged": false, "reason": "title not in own headline" },
    { "headline": "Head of Stock Administration at Asana", "matchedTitle": null, "charged": false, "reason": "title not in own headline" }
]
```

These are real headlines from a test run. A match needs the company in the employer spot for that title, as in "CFO at Stripe", "CFO | Stripe" or "Stripe CFO". So "CMO @ G2 || Advisor || Zoom" is not billed as Zoom's CMO, a name Google cut off with "..." is not trusted, and past or support roles such as "ex-Stripe", "Retired CFO" or "Assistant to the CFO" never count.

## How it works

```
job titles + companies + locations
            |
            v
Google search of public LinkedIn profiles, up to 8 fresh sessions for the first page
            |
            v
name, headline, location and profile URL for each person
            |
            v
charge bar: title and current company in the same part of the person's own headline
            |
            +--> confirmed      -->  Matched profile (charged)
            |
            +--> not confirmed  -->  delivered free, with the reason
```

Titles match their common forms, so a CFO search also finds "Chief Financial Officer", and a "VP of Sales" search also finds "Vice President, Sales" and "SVP of Sales".

## What data does it extract

| Field | What it is |
|---|---|
| `fullName` | Name as shown on LinkedIn |
| `headline` | The person's own LinkedIn headline |
| `location` | Location when Google shows it |
| `profileUrl` | Public LinkedIn profile URL |
| `isDecisionMaker`, `seniorityBand`, `department` | Read from the headline, for example cxo and finance |
| `matchedTitle`, `matchedCompany` | The searched title and company the headline confirmed |
| `charged`, `reason` | Whether the row was charged, and why |
| `searchedTitles`, `searchedCompany`, `searchedLocation` | The search that found the person |

## What is NOT returned

- Email addresses or phone numbers.
- Full work history, skills or education.
- Private profiles and people Google does not index.
- Sales Navigator data. The Actor uses no LinkedIn login and no cookies.
- Verified employment. A match is what the person's own public headline says, and headlines are self-reported. Several people can call themselves CTO of the same company.
- A profile link when Google hides it. Those people are delivered free with `profileUrl` empty.

## Quick start

1. Open the Actor and enter the job titles you sell to, for example `VP of Sales`.
2. Add the companies on your target list, as names or LinkedIn company URLs.
3. Run it and open the Profiles table, or download JSON, CSV or Excel.

```json
{ "titles": ["VP of Sales", "Head of Sales"], "companies": ["Stripe"], "maxResults": 50 }
```

## Input

```json
{
    "titles": ["CFO", "VP of Finance"],
    "companies": ["Asana", "https://www.linkedin.com/company/stripe/"],
    "locations": ["United States"],
    "maxResults": 200
}
```

| Field | Type | Default | Description |
|---|---|---|---|
| `titles` | array | required | Job titles to find, 1 to 30 |
| `companies` | array | | Company names or LinkedIn company URLs. A URL is read by its URL name, so use it only when that name is the company name, as in `linkedin.com/company/stripe`. When set, the company must be the current employer in the headline |
| `locations` | array | | Cities, regions or countries to narrow the search |
| `maxResults` | integer | 50 | Stop after this many profiles, matched or not, up to 2,000 |

## Output

One full record from a real run.

```json
{
    "fullName": "Patrick Collison",
    "headline": "Stripe CEO",
    "location": "",
    "profileUrl": "https://www.linkedin.com/in/patrickcollison/",
    "isDecisionMaker": true,
    "seniorityBand": "cxo",
    "department": "executive",
    "matchedTitle": "CEO",
    "matchedCompany": "Stripe",
    "charged": true,
    "reason": "title and current company confirmed in own headline",
    "searchedTitles": [
        "CEO",
        "CFO"
    ],
    "searchedCompany": "Stripe",
    "searchedLocation": null,
    "scrapedAt": "2026-09-23T22:44:25.660Z"
}
```

## Use from any MCP agent

```
https://mcp.apify.com/?tools=agnes.developer.queen/linkedin-people-search-scraper
```

Ask the agent for the CFO and the VP of Finance at a list of companies. It should read `matchedTitle`, `matchedCompany` and `profileUrl`, and skip rows where `charged` is false.

## Integrations

Call it once per row from Clay, n8n, Make or your own code. This returns the dataset in the same request.

```
POST https://api.apify.com/v2/acts/agnes.developer.queen~linkedin-people-search-scraper/run-sync-get-dataset-items?token=YOUR_APIFY_TOKEN
Content-Type: application/json

{ "titles": ["CMO"], "companies": ["Figma"], "maxResults": 20 }
```

It also works with `apify-client`, schedules and webhooks.

## Related Actors

- [LinkedIn New Hires Finder](https://apify.com/agnes.developer.queen/linkedin-new-hires-finder) finds decision makers who joined a company recently.

## Use cases

- **Outbound agencies.** Take the client's target account list, find the VP of Sales and Head of Sales at each, and send the matched rows to the sequencer.
- **Founders doing their own outbound.** Find the CFO at 50 target companies and write to each by name.
- **Clay tables.** For each company row, call the Actor for one title and write back the matched profile URL.
- **Recruiters.** Find CTOs and VPs of Engineering at companies in one city.

## FAQ

### Do I need LinkedIn cookies or an account?

No. The Actor reads public Google results for public LinkedIn profiles. It never logs in to LinkedIn.

### Why was a row free?

Its headline did not prove the match. The `reason` field says which part was missing, the title or the current company. Free rows are still yours to use.

### Does it return emails?

No. It returns the person's name, headline, location and LinkedIn URL.

### How many people will I get per company?

It depends on how many people at that company show the title in their public headline. Large companies return more. Small companies may return only a few, and you pay only for the ones that match.

### Is the match verified with the company?

No. The Actor bills what the person's own public LinkedIn headline says. Headlines are self-reported and can be out of date, and division leaders often write "CTO at" the parent company.

### Can I search by title only, without companies?

Yes. Leave `companies` empty. A row then bills when the person's own headline contains the title.
