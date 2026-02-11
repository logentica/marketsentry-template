# MarketSentry Template (Demo)

A lightweight demo tenant template for **bot-style products** on the Buildville platform.

This template intentionally focuses on a **credible Settings/Config UI** (and logs/dashboard pages) for validating:
- Discord bots (interactions)
- Polymarket-style alert bots
- “Operator bots” that run on a schedule

**Important:** This is a *demo-first* template. Connectors are currently simulated in the UI.

## What’s Included

- Astro + Tailwind UI
- Dashboard page (status + recent alerts)
- Settings page (connections + strategy + demo-only trading controls)
- Logs page (run timeline + event feed)

## What’s NOT Included (yet)

- Real Discord posting
- Real Polymarket integrations
- Trading execution (intentionally disabled)

## Development

```bash
cd site
npm install
npm run dev
```

## Deployment

Push to `main`.

This repo is meant to be registered as a **Buildville Template** (template_type: `custom`) and then used to create demo tenants.
