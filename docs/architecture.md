# Athar — System Design & Roadmap

## Current state (source of truth: code, not plans)

| Repo | State | What's actually there |
|---|---|---|
| **`athar-web`** | **Actively developed, deployed** | Next.js frontend, live at `openathar.org` (GitOps via `athar-ops`): Hero, Earth & Moon (real terminator/moon-phase computation, click-to-locate), world map with live prayer times (computed locally via a TypeScript port of `athan-core-java` — no external prayer-time API), "Two Books" section (Quran verse + AI-assisted observation, editorially reviewed), Islamic calendar (upcoming dates), DE/EN/AR with RTL. Also an unfinished, unmerged redesign branch (`design/b-noor`, dark gold/green theme) as a draft. |
| **`athan-core-java`** | **Published** | Java 25 / Maven library on Maven Central (`org.openathar:athan-core:0.1.0`): prayer times (PrayTimes.org v3.2 port), Qibla bearing, Hijri conversion (Umm al-Qura) — 38 reference tests. The single source of truth for calculation logic. |
| **`api-service`** | **V1 live in production** | Spring Boot 4.1.1 / Java 25, hexagonal, wraps `athan-core-java` (from Maven Central): `/v1/prayer-times`, `/v1/qibla`, `/v1/hijri` at `api.openathar.org`. Redis rate limiting (fixed window per client IP, fail-open), `Cache-Control: public, max-age=31536000, immutable`. 18 tests incl. ArchUnit. |
| **`athar-mobile-app`** | **Scaffold** | README + AGENTS.md only, no code, framework decision (Flutter vs. KMP) still open. Deliberately last in the build order. |

**Consequence for the roadmap:** the calculation logic is no longer
duplicated or provisional — `athan-core-java` exists, is published, and is
mirrored in the web frontend by a TypeScript port kept in sync with
reference tests. The remaining work is wiring: the API already consumes the
library, the mobile app will embed it once the framework decision is made
(see the roadmap section on the site: *Web tools — Live*, *Calculation core
— Live*, *Public API — V1*, *Mobile app — next*).

## Domain-driven design & bounded contexts

| Context | Type | Responsibility |
|---|---|---|
| **Calculation Engine** (`athan-core-java`) | Core Domain | Prayer times (MWL/ISNA/Umm Al-Qura...), Qibla, Hijri conversion — pure, stateless, no DB access |
| **Content Distribution** | Supporting | Quran, Hisn Al-Muslim, Ruqyah, Adhkar — versioned, CDN-friendly |
| **User Engagement / Sync** | Supporting | Khatma tracking, Tasbeeh counter, Ramadan dashboard — the only context with real user state |
| **Notification/Scheduling** | Supporting | Adhan triggers, local alarms, content push |
| **Public API Gateway** (`api-service`) | Open Host Service | Rate limiting, API keys, developer portal — a wrapper around Calculation + Content |
| **Identity** | Generic, deliberately minimal | No mandatory account for the core product — device ID + optional pairing code |

**Critical decision:** `athan-core-java` is the **single source of truth**
for calculation logic — identical client-side (offline) and server-side
(Public API), never reimplemented twice. The web frontend mirrors it via a
TypeScript port (`lib/athan-core.ts`) kept in sync by reference tests
against the Java values; the API consumes it directly from Maven Central.
Keep it Kotlin-Multiplatform-capable (JVM for backend, native for mobile)
so the mobile app can embed it without a rewrite.

## System architecture & API design

- **Modular monolith** to start (hexagonal, one module per bounded
  context), microservices only once scaling pressure is real.
- **Public API**: results for (lat, lon, date, method) are constant forever
  → aggressive HTTP caching (`Cache-Control: immutable`) + a CDN edge in
  front. Rate limiting via Redis fixed window per client IP (fail-open),
  API keys later.
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
- **`api-service` is deployed to production** at `api.openathar.org`
  (ArgoCD app `athar` in `athar-ops`, pinned image SHA, Traefik +
  Cloudflare tunnel). Redis runs in the `athar` namespace for rate
  limiting (fail-open when unreachable). PostgreSQL via the CNPG operator
  will come with user-sync data (Khatma/Tasbeeh) — not needed by the
  current stateless endpoints.
- Static content (Quran text/audio/fonts) via object storage + CDN, **not**
  through app pods — also only relevant once content distribution actually
  gets built.
- Public API reachability later via Cloudflare Tunnel (same pattern as
  other homelab services); at scale, a small Hetzner VPS as ingress instead
  of home bandwidth.
- HPA only on API-gateway pods, not on the calculation engine — a rule for
  later, not applicable yet (only `athar-web` is deployed today, and it
  doesn't need HPA).

## Next steps

The original "Sprint 1" plan (build the engine, switch the web to it, then
wrap it in an API) is **done** — the calculation engine is published, the
web computes locally, and the API serves V1 in production. What remains, in
order:

1. **`athar-mobile-app`**: decide Flutter vs. Kotlin Multiplatform, then
   scaffold — only now that the engine is embeddable as a library does a
   mobile app make sense (otherwise the same logic gets written a third
   time).
2. **API keys + developer portal** for the public API (rate-limit tiers,
   usage insights).
3. **Content distribution** (Quran text/audio/fonts, Adhkar) via object
   storage + CDN, once content governance (see below) is settled.

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
