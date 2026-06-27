# Canonical check command for this hardened static site.
# Wraps verify.sh so tooling can auto-detect a test/check target
# (a static site has no build step; this is the verification gate).
.PHONY: check test verify all

check: ## Run the static-site consistency checks (CSP hash sync, no-JS invariants, BIMI)
	@./verify.sh

test: check
verify: check
all: check
