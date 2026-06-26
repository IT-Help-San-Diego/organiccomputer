# AGENTS.md

Canonical, durable source of truth for all AI agents and human contributors on
the **organiccomputer.me** repository. Read this fully before making any edit.

/ A project of the **Intellectual Resistance** (intellectualresistance.com).
/ A product surface for IT Help San Diego — bookings always route through
/ schedule.it-help.tech; this site is the datasheet, not a booking system.

## What this site is

A single-page, dead-serious "datasheet" that specs the human mind like hardware
and benchmarks it against the supercomputer you'd otherwise have to buy. The
humor lives entirely in the *premise*; the copy stays scientific and sourced.
Themed as the same family as it-help.tech and dnstool.it-help.tech, but with its
own identity.

## Stack (deliberately minimal)

- **Plain static HTML/CSS. No build step. No framework. No JS at all.**
  `script-src 'none'` is enforced by the CSP — do not add scripts. If a feature
  seems to need JS, redesign it without JS or stop and ask the owner.
- One self-contained `index.html` (inline `<style>`), self-hosted assets in
  `assets/`. No external subresources, no fonts/CDNs, no trackers, no cookies.
- Why not Zola (like it-help.tech)? There is no blog/content collection to
  template — a generator would be machinery with nothing to do. The security
  posture comes from the CloudFront layer, not the framework.

## Engineering philosophy (hard quality bar)

Build clean from the foundations up; never defer quality for later cleanup.
Materially better than typical web builds, integrated across every angle:
speed, security, accessibility, code clarity, conversion psychology. Prefer
simple, durable architecture over short-term hacks. If a change introduces
debt, stop and redesign before merging.

## Acceptance gates (required)

- **Lighthouse:** target 100/100/100/100 on the homepage; no regression without
  written rationale.
- **Mozilla Observatory / security posture:** target A+ and score >= 120.
- **CSP:** `default-src 'none'`, `script-src 'none'`, tight per-type allowlists.
  Never weaken it to add a convenience. (Source of truth:
  `infra/cloudfront/security-headers.json`.)
- **No trackers, no cookies, no third-party requests, no framework bloat.**
- **Accessibility:** WCAG-compliant contrast and readable typography, including
  for older users.
- **Performance:** no layout shift, no unnecessary bytes; keep CSS intentional.
- **Trust/psychology:** calm authority, competence, clarity — no visual noise.

If a gate cannot be met, document the reason + rollback path in the PR notes.

## Sourcing discipline (non-negotiable)

Every factual claim/number on the page must be backed by a high-authority,
citable source (gov / peer-reviewed / primary). No hyperbole, no invented
statistics. The references list at the bottom is load-bearing — keep it
accurate and numbered. This mirrors the dnstool "Verification Principle":
honest priors, evidence-weighted claims, never overclaim ("first", etc.).

## Email lockdown (this is NOT an email domain)

DNS is hardened so the domain cannot be used to send/spoof mail:
- `MX "0 ."` (null MX, RFC 7505)
- `TXT "v=spf1 -all"` (no senders authorized)
- `_dmarc TXT "v=DMARC1; p=reject; ..."`
- no DKIM selectors
Do not add mail records without explicit owner direction.

## Deploy pipeline

Automatic on push to `main` via `.github/workflows/deploy.yml`:
1. (No build — static files are shipped as-is.)
2. Push CloudFront response-headers policy from
   `infra/cloudfront/security-headers.json` (idempotent).
3. S3 sync: immutable assets long-cache; `*.html` short-cache; `--delete`.
4. CloudFront invalidation `/*` and wait for completion.

Hosting: private S3 bucket (OAC-only) behind CloudFront, ACM cert in
**us-east-1**, Route 53 zone `organiccomputer.me` (account 433198535569).

## Canonical files

- Page: `index.html` (inline visual system)
- 404: `404.html`
- Security headers / CSP: `infra/cloudfront/security-headers.json`
- Deploy: `.github/workflows/deploy.yml`
- Crawl: `robots.txt`
- Brand mark: `favicon.svg`

## House rules

- Keep the repo Sonar-clean: no dead CSS, no duplicate selectors, no `.DS_Store`.
- Don't introduce palette colors ad hoc — reuse the CSS custom properties already
  defined in `index.html` `:root`.
- Brand/architecture: "Organic Computer" is the product; "Intellectual
  Resistance" is the umbrella. Keep the cross-links intact.
