# ADR-001: athan-core is the single source of truth (drop Aladhan)

## Status
Accepted

## Date
2026-09-14

## Context

The Athar platform needs prayer times and Hijri dates in four places: the
web frontend (`athar-web`), the public API (`api-service`), the mobile app
(`athar-mobile-app`, offline-capable), and the marketing site. Today the
web calls the external Aladhan API for prayer times and computes Hijri
conversion itself in `lib/hijri.ts` — a deliberate interim step to prove
the product works before building the real engine.

The interim step has now served its purpose: `athan-core-java` exists as a
pure Java 25 / Maven module with prayer times (PrayTimes.org v3.2 port,
11 calculation methods) and Hijri conversion (Umm al-Qura via
`HijrahChronology`), verified against reference values generated from the
official praytime.js v3.2 library and cross-checked against the
independent Adhan implementation (max. 1 min deviation on dhuhr/asr/
maghrib/isha, exact on fajr/sunrise/sunset).

## Decision

`athan-core-java` is the **single source of truth** for calculation logic.
All four consumers use it — the web via WASM or a small JS port, the API
and mobile by embedding the library directly. The Aladhan dependency is
dropped once the web switches over; no other component may reimplement the
calculation a second time.

## Alternatives Considered

### Keep calling Aladhan everywhere
- Pros: Zero migration effort, battle-tested API.
- Cons: External dependency for a core feature; no offline capability for
  mobile; the calculation is not ours to fix or extend; rate limits and
  availability outside our control; violates the "never reimplemented
  twice" goal in a different way (the logic lives in someone else's
  black box).
- Rejected: A privacy-respecting, ad-free, offline-capable platform cannot
  depend on a third party for its most fundamental feature.

### Reimplement the calculation separately per consumer
- Pros: Each consumer uses its native language.
- Cons: Four copies of the same astronomy drift apart; the exact problem
  the architecture doc calls out ("never reimplemented a second time").
- Rejected: The whole point of `athan-core-java` is one verified
  implementation, tested once against reference values.

### Keep the web's JS implementation as the reference (status quo)
- Pros: No work needed.
- Cons: The web's logic is ad-hoc, untested against reference values, and
  coupled to Aladhan's response format; it cannot serve the API or mobile.
- Rejected: The web remains the de-facto reference only until the core
  exists — which is now.

## Consequences

- The web's `lib/hijri.ts` and prayer-time parameters count as the spec
  for the core port; once the web switches to the core, the core becomes
  the spec and the web's copies are deleted.
- `api-service` wraps `athan-core-java` directly (no HTTP hop to Aladhan).
- Mobile embeds the library; the only migration point is replacing
  `HijrahChronology` (JVM) with an embedded Umm al-Qura table.
- Known drift risks (high-latitude NaN→0, Adhan ±1 min, Hijri ±4-day
  window, JVM HijrahChronology range) are documented in
  `core/known-drift-risks.md` and must be handled by consumers.
- Aladhan remains usable as a manual cross-check tool, not as a runtime
  dependency.