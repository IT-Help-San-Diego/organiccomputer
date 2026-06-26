# organiccomputer.me

The human mind, spec'd like hardware — and priced against the supercomputer
you'd otherwise have to buy.

A single-page scientific datasheet. **A project of the
[Intellectual Resistance](https://intellectualresistance.com).**

## Stack

Plain static HTML/CSS. No build step, no framework, **no JavaScript**
(`script-src 'none'`). Self-hosted assets only — no trackers, no cookies, no
third-party requests. Hardened to an A+ security posture via CloudFront response
headers.

## Layout

| Path | Purpose |
|------|---------|
| `index.html` | The datasheet (self-contained, inline visual system) |
| `404.html` | Themed not-found page |
| `assets/` | Self-hosted images (brain centerpiece, WebP + JPEG) |
| `favicon.svg` | Brand mark |
| `robots.txt` | Crawl policy |
| `infra/cloudfront/security-headers.json` | CSP + security headers (source of truth) |
| `.github/workflows/deploy.yml` | S3 sync + CloudFront invalidation on push to `main` |
| `AGENTS.md` | Governance — **read before editing** |

## Deploy

Push to `main` → GitHub Actions syncs to S3 (private, OAC-only) behind
CloudFront (ACM cert, us-east-1), pushes the security-headers policy, and
invalidates the cache. Local preview: open `index.html` in a browser.

## Local development

No toolchain required. Edit `index.html`, open it in a browser. See `AGENTS.md`
for the quality gates (Lighthouse 100s, Observatory A+/≥120, strict CSP,
sourcing discipline).
