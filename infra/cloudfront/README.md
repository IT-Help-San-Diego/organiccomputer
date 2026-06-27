# CloudFront response-headers policies

This site uses **two** response-headers policies, by design:

## `security-headers.json` — the DOCUMENT policy (default behavior `*`)
Maximum lockdown for the HTML page: strict CSP (`script-src 'none'`, hashed `style-src`),
`Cross-Origin-Resource-Policy: same-origin`, COOP `same-origin`, COEP `credentialless`,
HSTS preload, XFO DENY, locked Permissions-Policy. This is what earns the A+ posture.

## `assets-headers.json` — the ASSETS policy (cache behavior `/assets/*`)
Identical hardening **except**:
- `Cross-Origin-Resource-Policy: cross-origin`
- `Cross-Origin-Embedder-Policy: unsafe-none`

### Why — DO NOT revert this to same-origin
Apple iMessage / Messages link previews (and Slack, Facebook, Twitter/X, Discord)
fetch the Open Graph image (`/assets/og-card.jpg`) from a **different origin** than this
domain. `Cross-Origin-Resource-Policy: same-origin` tells that fetcher "only same-origin
may load this resource," so the preview image is silently **blocked** — the link unfurls
with no picture (this is the exact bug that made iMessage show no image even though the
og:image meta, dimensions, and content-type were all correct).

A public Open Graph image is *meant* to be embedded cross-origin, so `cross-origin` is the
correct, standard, safe value here. The document itself stays `same-origin` — the page is
not embeddable, only its public preview image is. This split preserves the A+ security
posture while letting link previews work everywhere.

## How it's wired (not managed by the deploy workflow)
The GitHub Actions deploy syncs files to S3; it does NOT manage CloudFront behaviors.
The `/assets/*` cache behavior + this policy were created via the AWS CLI. If the
distribution is ever rebuilt from scratch, recreate:
1. `aws cloudfront create-response-headers-policy --response-headers-policy-config file://infra/cloudfront/assets-headers.json`
2. add a `/assets/*` cache behavior to the distribution pointing at the same S3 origin with that policy id
3. invalidate `/assets/*`
