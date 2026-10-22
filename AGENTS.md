# AGENTS.md — Athar (openathar)

Non-profit Sadaqah Jariyah project: a free, ad-free, privacy-respecting
Islamic platform (web/Android/iOS) + public API. Fully open source under the
GitHub org **`openathar`**. Campaign: "Leave your Athar" — code as a lasting
good deed.

## Links

- Repo conventions: `~/Development/harness/agents/business-repo.md`
- Repo map: `~/Development/harness/docs/repo-map.md`
- AGENTS.md convention ("map, not manual"): `~/Development/harness/agents/agents-md-convention.md`
- Skills (global): `~/.agents/skills/`

This folder is the **superproject** (same pattern as `business/wasilah`) —
the actual repos live under the `openathar` org and are wired in here as git
submodules: `core/` → `athan-core-java`, `api/` → `api-service`, `mobile/` →
`athar-mobile-app`, `web/` → `athar-web`.

## Architecture & roadmap

Full system design (bounded contexts, API design, mobile constraints,
DevOps, current status per repo, open critical questions):
[`docs/architecture.md`](docs/architecture.md).

## Things to know

- `core/` (`athan-core-java`) is the **single source of truth** for
  calculation logic — published on Maven Central, consumed by `api/`, and
  mirrored by a TypeScript port (`core-ts/`, also used in `web/` and
  `mobile/`) that is kept in sync by reference tests. Never reimplement a
  calculation a second time.
- `web/` and `api/` are both deployed to production (`openathar.org`,
  `api.openathar.org`, GitOps via `athar-ops`); `mobile/` is an MVP. See
  [`docs/architecture.md`](docs/architecture.md) for the honest state of each.
- The API roadmap is shipped except Qur'an/Adhkar content (needs a
  licence-clean text source — a product decision). The tree video on the web
  start page has an unclarified licence: `web/public/beit-athar/CREDITS.md`.
- Submodule discipline: work inside the submodule folder, then bump the
  pointer here. No extra top-level clone.

## APM (Agent Package Manager)

Project-local skills/agents/commands are managed via `apm.yaml`
(registry source: `~/Development/harness/registry/`).
- `apm install --local` — installs the packages listed in `apm.yaml`
- `apm status --local` — checks install state against the registry
