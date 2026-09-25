# LinkedIn New Hires Finder

LinkedIn New Hires Finder is an Apify Actor that takes a company website, name, or LinkedIn URL and returns decision makers who started at that company recently, with the month they started and the company they left, only when the current-employer match clears the bar.

## Pricing

The Actor is free on Apify at the moment. Pay per event pricing is planned, with a start fee and a charge only for a decision maker who is currently at the company you named and whose start month sits inside your tenure window. Rows that fail that bar will stay free.

## The differentiator

Harvest-style scrapers dump a roster. This actor dumps a trigger.

```json
{
  "fullName": "Jane Doe",
  "title": "VP of Sales",
  "company": "stripe",
  "isDecisionMaker": true,
  "seniorityBand": "vp",
  "department": "sales",
  "startedAt": "2026-03",
  "tenureMonths": 6,
  "previousCompany": "HubSpot",
  "previousTitle": "Director of Sales",
  "whyNow": "new-decision-maker",
  "confidence": "medium",
  "charged": true,
  "profileUrl": "https://www.linkedin.com/in/jane-doe"
}
```

`whyNow` is `new-decision-maker` only on billed rows. Stale tenures and missing dates stay `stale-tenure` or `unknown-tenure` and are not charged.

## How it works

```
company URL or name
        |
        v
Google public index of LinkedIn profiles (decision-maker titles)
        |
        v
headline names the company?  no -> emit free
        |
       yes
        |
        v
decision maker (owner, founder, C level, VP, director)?  no -> skip before charge
        |
       yes
        |
        v
start month inside window (from indexed text, else public profile)?  no -> emit free
        |
       yes
        |
        v
charge new-hire, push the trigger row
```

Discovery uses Apify Google SERP proxies. Date enrichment uses Apify residential. No LinkedIn login. No cookies. No Sales Navigator.

## What is NOT returned

- emails
- phone numbers
- Sales Navigator rows
- guessed hires from "first time we crawled this profile"
- departures
- full work history beyond current start month and previous company

## Where to run it

The Actor runs on Apify at https://apify.com/agnes.developer.queen/linkedin-new-hires-finder. The page has the input form, the pricing and a free trial on the Apify free plan.
