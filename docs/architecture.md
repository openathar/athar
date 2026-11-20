# Athar — System Design & Roadmap

## Current state (source of truth: code, not plans)

| Repo | State | What's actually there |
|---|---|---|
| **`athar-web`** | **Actively developed, deployed** | Next.js 15 frontend, live at `openathar.org` (GitOps via `athar-ops`). The start page is "the tree under the moon": a real 3D moon (today's phase) in the hero, then six chapters — calculation, features, idea, calendar, API, take part — while a tree in the side navigation grows as you scroll. Inside: the tabbed cosmos section (3D Earth with computed day/night terminator, clickable globe with live prayer times from a TypeScript port of `athan-core-java` — no external prayer-time API), "Eight faces of one moon", the "Written & Witnessed Book" (Quran verse + AI-assisted, editorially reviewed observation, fresh pairs from `/api/reflections`), upcoming Islamic dates, and an interactive emotion map (133 feelings as branches and roots, after the research model of Amin Sabry; names handwritten per language). The developer portal (`/developers`, linked in the header) shares the same dark/gold look. DE/EN/AR with RTL. The tree is a template video whose licence is **not yet clarified** (`web/public/beit-athar/CREDITS.md`). |
| **`athan-core-java`** | **Published** | Java 25 / Maven library on Maven Central (`org.openathar:athan-core:0.1.0`): prayer times (PrayTimes.org v3.2 port), Qibla bearing, Hijri conversion (Umm al-Qura) — 38 reference tests. The single source of truth for calculation logic. |
| **`api-service`** | **V1 live in production** | Spring Boot 4.1.1 / Java 25, hexagonal, wraps `athan-core-java` (from Maven Central). 15 endpoints at `api.openathar.org`: prayer times (day, date range, batch, current/next prayer, iCalendar feed), `/v1/methods`, `/v1/qibla`, `/v1/hijri` and `/v1/calendar/{hijri,gregorian}`, `/v1/events`, `/v1/moon`, `/v1/places` (bundled GeoNames extract, CC BY 4.0), self-serve API keys. Redis rate limiting (fixed window per client IP or key, fail-open), `Cache-Control: immutable` on deterministic answers. 61 tests incl. ArchUnit and USNO moon reference times. |
| **`athar-mobile-app`** | **1.0 ready for store (2026-11-20)** | React Native / Expo (SDK 58, expo-router native tabs), the website's design and story: first-open welcome ("A trace that keeps going.", permissions explained before any prompt), prayer screen with the real moon and numbered chapters, Qibla compass, Sky (moon, Hijri month, observances), Tree (tasbih counter that grows a code-drawn tree per seed + the website's feelings tree), per-prayer adhan alarms (local notifications, never push), five languages with RTL. Computes locally via `@openathar/athan-core-ts`; 25 unit tests (`npm test`). Plan: `mobile/docs/release-1.0.md`. Open: device test, iOS submission (weekend), Android after Google's 14-day closed test. |

**Consequence for the roadmap:** the calculation logic is no longer
duplicated or provisional — `athan-core-java` exists, is published, and is
mirrored in the web frontend by a TypeScript port kept in sync with
reference tests. The remaining work is wiring: the API already consumes the
library, the mobile app embeds it (`@openathar/athan-core-ts`).
On the site's roadmap this reads: *Web tools — Live*, *Calculation core —
Live*, *Public API — V1*, *Mobile app — in progress*.

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
The mobile app shares the web's port as `@openathar/athan-core-ts`
(same calculation core for web + app); moon-phase math lives in the same
shared package.

## System architecture & API design

- **Modular monolith** to start (hexagonal, one module per bounded
  context), microservices only once scaling pressure is real.
- **Public API**: results for (lat, lon, date, method) are constant forever
  → aggressive HTTP caching (`Cache-Control: immutable`; exceptions are the
  answers that mean "now": Hijri/events/ICS without a date are cached for
  5 minutes to 1 hour, `next` and `moon` without `at` not at all) + a CDN edge in
  front. Cloudflare proxies `api.openathar.org` today but does not cache the
  JSON (`cf-cache-status: DYNAMIC`) — a cache rule would make the immutable
  headers pay off at the edge. Rate limiting via Redis fixed window per
  client IP or API key (fail-open); self-serve API keys are live.
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
- Framework decision made: **React Native / Expo** (SDK 58). The MVP screens
  exist; not done yet: on-device verification of location + notifications,
  adhan audio, store submission.

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
  limiting (fail-open when unreachable) **and** for self-serve API keys
  (`POST /v1/api-keys`, no TTL). Known gap: Redis has no persistence
  (`--save "" --appendonly no`), so every restart silently drops all issued
  keys (clients fall back to the IP limit). Decision (2026-11-15): add AOF
  + a 1 Gi `local-path` PVC now, migrate keys to PostgreSQL once the CNPG
  operator lands in the `athar` namespace (together with user-sync data:
  Khatma/Tasbeeh).
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

1. **`athar-mobile-app`**: 1.0 is built and announced (blog, 2026-11-20) —
   on-device verification, iOS submission, Android closed test (12 testers,
   14 days); a custom adhan sound comes after launch.
2. **Content distribution** (Quran text/audio/fonts, Adhkar) via object
   storage + CDN, once content governance (see below) is settled.

Shipped since the last pass: the API roadmap — date ranges, current/next
prayer, method catalogue, batch, iCalendar feed, moon, observances, Hijri
month grid and reverse conversion, city lookup — all documented in the portal
and the `api-service` README; only Qur'an/Adhkar content remains (blocked on a
licence-clean text source). The start page was redesigned (see the web row
above). Before that: a custom developer portal at
`openathar.org/[locale]/developers` (explicitly not Swagger UI). The
reference itself is English-only; only header/footer/title follow en/de/ar
and RTL, and all three URLs canonicalize to `/en/developers`. It is
spec-driven (`web/lib/api-reference.ts` → index, panels, cURL/JS/Python/
Swift/Kotlin samples), with a live in-browser API playground and self-serve
API-key issuance/usage lookup — calling `api.openathar.org` directly via
CORS (allowed origins: openathar.org and http://localhost:3000).

API hardening shipped with it: every failure answers `{"error": "..."}` (no
Spring default bodies, no 500 for Hijri dates outside the Umm al-Qura table),
prayer-time fields are `null` where an event does not occur (polar day/night)
instead of made-up clock values — a v1 contract change for clients that
assumed non-null strings — and key labels are capped at 64 characters.

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
   translations need to be cleared before integration. Also open: the
   licence of the template media on the start page (tree video, a few
   images — see `web/public/beit-athar/CREDITS.md`); and attribution for the
   GeoNames data behind `/v1/places` (CC BY 4.0, already in every response).
4. ~~Design decision pending~~ **resolved (2026-11-15)**: the
   `design/b-noor` branch was a stale draft (five commits behind `main`,
   without the security fix and the current features). Discarded — the
   branch is deleted; `main` (tree under the moon, 3D earth, dark gold) is
   the design.
