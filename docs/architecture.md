# Athar — System Design & Roadmap

## Current state (source of truth: code, not plans)

| Repo | State | What's actually there |
|---|---|---|
| **`athar-web`** | **Actively developed, deployed** | Next.js frontend, live at `openathar.org` (GitOps via `athar-ops`): Hero, Earth & Moon (real terminator/moon-phase computation, click-to-locate), world map with live prayer times (Aladhan API), "Two Books" section (Quran verse + AI-assisted observation, editorially reviewed), Islamic calendar (upcoming dates), DE/EN/AR with RTL. Also an unfinished, unmerged redesign branch (`design/b-noor`, dark gold/green theme) as a draft. |
| **`athan-core-java`** | **Scaffold** | README + AGENTS.md only, no code. Prayer-time logic today lives ad-hoc in the web app (Aladhan API call + its own JS Hijri conversion in `lib/hijri.ts`) — not yet extracted into a portable library. |
| **`api-service`** | **Scaffold** | README + AGENTS.md only, no code, no endpoint. |
| **`athar-mobile-app`** | **Scaffold** | README + AGENTS.md only, no code, framework decision (Flutter vs. KMP) still open. |

**Consequence for the roadmap:** calculation logic is currently
**duplicated and provisional** — the web app calls an external API
(Aladhan) for prayer times and computes Hijri conversion itself in
JavaScript. That's not the end state, it's the deliberate interim step of
"prove it works first, then build the real engine" (see the roadmap section
on the site itself: *Web tools — Live*, *Calculation core — In progress*).

## Domain-driven design & bounded contexts

| Context | Type | Responsibility |
|---|---|---|
| **Calculation Engine** (`athan-core-java`) | Core Domain | Prayer times (MWL/ISNA/Umm Al-Qura...), Qibla, Hijri conversion — pure, stateless, no DB access |
| **Content Distribution** | Supporting | Quran, Hisn Al-Muslim, Ruqyah, Adhkar — versioned, CDN-friendly |
| **User Engagement / Sync** | Supporting | Khatma tracking, Tasbeeh counter, Ramadan dashboard — the only context with real user state |
| **Notification/Scheduling** | Supporting | Adhan triggers, local alarms, content push |
| **Public API Gateway** (`api-service`) | Open Host Service | Rate limiting, API keys, developer portal — a wrapper around Calculation + Content |
| **Identity** | Generic, deliberately minimal | No mandatory account for the core product — device ID + optional pairing code |

**Critical decision:** `athan-core-java` is meant to become the **single
source of truth** for calculation logic — identical client-side (offline)
and server-side (Public API), never reimplemented twice. As long as this
repo is a scaffold, the web app is the de-facto reference implementation
(even though today it partly leans on external APIs instead of its own
calculation) — when `athan-core-java` gets built, the web's logic
(`lib/hijri.ts`, prayer-time parameters) counts as the spec, not
PrayTimes.org alone. Pure Java 25 / Maven, no Spring, no state — the mobile
target embeds it as a library (the only migration point is replacing
`HijrahChronology` with an embedded Umm al-Qura table).

## System architecture & API design

- **Modular monolith** to start (hexagonal, one module per bounded
  context), microservices only once scaling pressure is real.
- **Public API**: results for (lat, lon, date, method) are constant forever
  → aggressive HTTP caching (`Cache-Control: immutable`) + a CDN edge in
  front. Rate limiting via Redis token bucket per API key + a base IP limit
  for anonymous use (same pattern as the Aladhan API the web currently uses
  as a placeholder).
- **No GraphQL for V1** — the data models are flat, REST + cache headers
  are enough.
- **Sync strategy**: the app always computes prayer times locally (embedded
  `athan-core-java`), the server is only used for GPS→location resolution.
  Only Khatma progress/Tasbeeh get synced, with no mandatory account
  (device ID + optional pairing code, last-write-wins + a monotonic
  counter).

## Mobile constraints

- **Never rely on push for Adhan timing** (Doze Mode / iOS background
  throttling are unreliable for second-accurate triggers).
- Android: `WorkManager` computes N days ahead, `AlarmManager
  .setExactAndAllowWhileIdle` + explicit `SCHEDULE_EXACT_ALARM` permission
  (Android 12+) + battery-optimization exemption dialog.
- iOS: local `UNUserNotificationCenter` notifications ~7 days ahead,
  refreshed via `BGAppRefreshTask`/`BGProcessingTask`. Live Activities as a
  timer style (fixed end date) — no periodic push needed.
- Smart-speaker integration (Alexa/Google Home) is decoupled, only calls the
  Public API — no influence on mobile architecture.
- Not started yet: no code, no framework decision (Flutter vs. Kotlin
  Multiplatform) made.

## DevOps & hosting

- **Homelab reality (as of now):** there is only **one** production k3s
  cluster (`lenserver` + `lenserver2`, 2 nodes). The former opi/k3d dev
  cluster has been decommissioned — any mention of "k3d" or a "dev stage"
  in older notes is stale.
- **`athar-web` is deployed to production.** GitOps via ArgoCD from the
  `athar-ops` repo (AppProject `athar-prod`, Application `athar-web`,
  namespace `athar` on the prod cluster): Deployment pinned to the commit
  SHA (`ghcr.io/openathar/athar-web:main-<sha>`, never `:latest`), Traefik
  IngressRoute for `openathar.org` + `www.openathar.org`, TLS via
  cert-manager, Cloudflare in front. Image updates happen only in
  `athar-ops`, never via `kubectl set image`.
- Once `api-service` has code: PostgreSQL via the CNPG operator (user-sync
  data is small), a single Redis instance for cache + rate limiting —
  neither exists yet since there's no backend code that needs them.
- Static content (Quran text/audio/fonts) via object storage + CDN, **not**
  through app pods — also only relevant once content distribution actually
  gets built.
- Public API reachability later via Cloudflare Tunnel (same pattern as
  other homelab services); at scale, a small Hetzner VPS as ingress instead
  of home bandwidth.
- HPA only on API-gateway pods, not on the calculation engine — a rule for
  later, not applicable yet (only `athar-web` is deployed today, and it
  doesn't need HPA).

## Next steps (not "Sprint 1" — the web is already ahead of that)

The original "Sprint 1" plan assumed an empty web app — that's outdated.
Realistic next steps, in order:

1. **Start `athan-core-java`**: a pure Java 25 / Maven module (no Spring),
   prayer-time algorithm (reference: the PrayTimes.org spec, cross-checked
   against the parameters the web already shows via Aladhan) + rebuild the
   Hijri conversion from `web/lib/hijri.ts` exactly (don't reinvent it — use
   the same reference values, so web and engine never drift apart). Unit
   tests against known reference values are mandatory.
2. **Switch the web app to the real engine**: once `athan-core-java`
   exists, move `lib/prayer-times.ts` from an Aladhan fetch to the actual
   calculation (WASM or a small JS port, still to be decided).
   That's the moment "Calculation core" flips from *In progress* to *Live*.
3. **`api-service` after that**: a thin wrapper around `athan-core-java`,
   `GET /v1/prayer-times?lat&lon&date&method`, Redis cache + rate limiting,
   deployed to the existing prod cluster (same GitOps pattern as
   `athar-web`).
4. **`athar-mobile-app` last**: only once the engine is embeddable as a
   library does a mobile scaffold make sense (otherwise the same logic gets
   written a third time).

## Open critical questions (resolve before public launch)

1. **Content governance**: who verifies Quran text/hadith authenticity/
   madhhab-specific methods (an Ijazah-holder review process)? The current
   "Two Books" section uses AI-drafted, editorially reviewed observation
   text (see `data/reflections.json`, field
   `provenance.arabicApproved: false` — the Arabic version isn't approved
   yet).
2. **Sustainability without ads/tracking**: a funding model for
   infrastructure (Sadaqah/Waqf/sponsorship), possibly a non-profit
   association as the legal entity behind SLA-capable public API hosting.
3. **Content licensing**: usage rights for Mushaf fonts, recitations,
   translations need to be cleared before integration.
4. **Design decision pending**: the `design/b-noor` branch (dark gold/green
   theme, different header, world map with city picker) is a parallel
   design draft to the current `main` design — not yet decided whether or
   how the two get merged.
