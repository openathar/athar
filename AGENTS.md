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

- `core/` (`athan-core-java`) is meant to become the **single source of
  truth** for calculation logic — used server- **and** client-side, never
  reimplemented a second time. First code landed (Java 25 / Maven: prayer
  times + Hijri with reference tests); until the web is switched over,
  `web/` remains the de-facto reference implementation, even though it
  currently leans on an external API (Aladhan) as a placeholder.
- `web/` is the only repo deployed to production today — see
  [`docs/architecture.md`](docs/architecture.md) for the honest state of
  the other three.
- Submodule discipline: work inside the submodule folder, then bump the
  pointer here. No extra top-level clone.

## APM (Agent Package Manager)

Project-local skills/agents/commands are managed via `apm.yaml`
(registry source: `~/Development/harness/registry/`).
- `apm install --local` — installs the packages listed in `apm.yaml`
- `apm status --local` — checks install state against the registry
