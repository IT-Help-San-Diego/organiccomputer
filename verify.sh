#!/usr/bin/env bash
# verify.sh — canonical consistency check for this hardened static site.
# Exits non-zero on any failure so it can serve as the repo's check command
# (and stop the "unverified" flag from re-firing every turn).
#
# Usage:  ./verify.sh            # checks local files (a draft)
#         RELEASE=1 ./verify.sh  # also refuses fields left unfilled in a draft;
#                                # the deploy workflow runs it this way
# Checks are intentionally fast, dependency-free (bash + python3 stdlib).
set -euo pipefail
cd "$(dirname "$0")"

fail=0
ok(){ printf '  [PASS] %s\n' "$1"; }
no(){ printf '  [FAIL] %s\n' "$1"; fail=1; }

python3 - <<'PY' || fail=1
import re, hashlib, base64, json, sys, os
fails=[]
def k(name, cond):
    print(f"  [{'PASS' if cond else 'FAIL'}] {name}")
    if not cond: fails.append(name)

html = open("index.html", encoding="utf-8").read()

# 1. CSP style-hash consistency (the #1 cause of a blank page)
style = re.search(r"<style>(.*?)</style>", html, re.S).group(1)
real = "sha256-" + base64.b64encode(hashlib.sha256(style.encode()).digest()).decode()
meta = re.search(r"style-src 'self' '(sha256-[^']+)'", html)
k("index.html meta CSP style-hash == real <style> hash", bool(meta) and meta.group(1) == real)

pol_path = "infra/cloudfront/security-headers.json"
if os.path.exists(pol_path):
    pol = open(pol_path).read()
    polm = re.search(r"style-src 'self' '(sha256-[^']+)'", pol)
    k("CloudFront policy style-hash == real <style> hash", bool(polm) and polm.group(1) == real)
    try:
        json.loads(pol); k("security-headers.json parses", True)
    except Exception as e:
        k(f"security-headers.json parses ({e})", False)

# 2. No-JS / no-inline-style invariants (CSP is script-src 'none')
k("zero inline style= attributes", len(re.findall(r'\sstyle="[^"]*"', html)) == 0)
k("only ld+json <script> blocks (no executable JS)",
  all("application/ld+json" in s for s in re.findall(r"<script[^>]*>", html)))
k("no external subresources (src/srcset http[s])",
  len(re.findall(r'(?:src|srcset)="https?://[^"]*"', html)) == 0)

# 3. JSON-LD validity
m = re.search(r'<script type="application/ld\+json">(.*?)</script>', html, re.S)
if m:
    try:
        json.loads(m.group(1)); k("JSON-LD parses", True)
    except Exception as e:
        k(f"JSON-LD parses ({e})", False)

# 4. No leftover placeholders
k("no PLACEHOLDER tokens", "PLACEHOLDER" not in html)

# 5. BIMI logo (if referenced) is well-formed SVG Tiny-PS
if os.path.exists("bimi-logo.svg"):
    import xml.dom.minidom as X
    svg = open("bimi-logo.svg").read()
    try:
        X.parseString(svg); wf = True
    except Exception:
        wf = False
    k("bimi-logo.svg well-formed XML", wf)
    k("bimi-logo.svg is SVG Tiny-PS (baseProfile)", 'baseProfile="tiny-ps"' in svg)
    k("bimi-logo.svg has <title>", "<title>" in svg)
    k("bimi-logo.svg no scripts/external refs",
      not any(b in svg for b in ["<script", "xlink:href", 'href="http', "<animate"]))

# 6. Stale-content guard: forbidden phrases must not appear in ANY shipped text file
#    (case-insensitive — catches uppercase SVG <text> the way a global rename can miss).
#    Edit FORBIDDEN to match this site's retired wording.
FORBIDDEN = ["done right", "book.squareup.com", "v = i·r", "closest silicon match"]
shipped_ext = (".html", ".svg", ".txt", ".xml", ".json", ".webmanifest")
skip_dirs = (".git", ".github", "node_modules")
shipped = {}
for root, dirs, files in os.walk("."):
    dirs[:] = [d for d in dirs if d not in skip_dirs]
    for fn in files:
        if not fn.lower().endswith(shipped_ext):
            continue
        p = os.path.join(root, fn)
        try:
            shipped[p] = open(p, encoding="utf-8", errors="ignore").read().lower()
        except Exception:
            continue
def hits(phrases):
    return [f"{p}: '{ph}'" for p in sorted(shipped) for ph in phrases if ph.lower() in shipped[p]]
stale_hits = hits(FORBIDDEN)
k("no stale/retired phrases in shipped files" + (f" (hits: {stale_hits})" if stale_hits else ""),
  len(stale_hits) == 0)

# 6b. Unfilled fields. A line can be drafted before the fact it states exists:
#     the pointer to the family corrections index is written before its entry is
#     logged, with the day as "DD MONTH YYYY" and the identifier as
#     "C-YYYYMMDD-NN". A draft may carry them, and says so. A release may not:
#     the deploy workflow sets RELEASE=1, so a page with an unfilled field is
#     never uploaded. Matching ignores case, so the link's "#c-yyyymmdd-nn"
#     is caught too.
UNFILLED = ["DD MONTH YYYY", "C-YYYYMMDD-NN"]
unfilled_hits = hits(UNFILLED)
release = os.environ.get("RELEASE", "") not in ("", "0")
held = bool(unfilled_hits) and not release
if held:
    print(f"  [HOLD] unfilled fields, refused when RELEASE=1 (hits: {unfilled_hits})")
else:
    k("no unfilled fields in shipped files" + (f" (hits: {unfilled_hits})" if unfilled_hits else ""),
      len(unfilled_hits) == 0)

# 7. OG image must be a raster (Apple/iMessage will not render an SVG og:image)
og = re.search(r'property="og:image"\s+content="[^"]+\.(svg|png|jpg|jpeg)"', html)
if og:
    k("og:image is raster (png/jpg, not svg — iMessage requirement)", og.group(1).lower() != "svg")

if fails:
    print("=" * 52); print(f"FAILED: {len(fails)} check(s)"); sys.exit(1)
print("=" * 52)
print("All checks passed." + (" One is held: this draft is not ready for release." if held else ""))
PY

if [ "$fail" -ne 0 ]; then
  echo "verify.sh: FAILED"
  exit 1
fi
echo "verify.sh: OK"
