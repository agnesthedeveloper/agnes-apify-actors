# LinkedIn People Search Scraper

For companies advertising open roles, [LinkedIn Jobs Scraper](linkedin-jobs-scraper.md) provides job descriptions and recurring new-job feeds.

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

## Where to run it

The Actor runs on Apify at https://apify.com/agnes.developer.queen/linkedin-people-search-scraper. The page has the input form, the pricing and a free trial on the Apify free plan.
