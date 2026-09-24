# Athar (أثر)

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/logo-dark.png" />
    <img src="docs/logo-light.png" alt="Athar — the word أثر" width="560" />
  </picture>
</p>

> *"And We record what they have put forth, and their traces (āthār)."*
> — Surah Ya-Sin (36:12)

**Athar** — the trace, the footprint, the mark that outlives you.

A 100% free, ad-free, privacy-respecting Islamic platform (web, Android,
iOS) plus a public API for developers — built as **Sadaqah Jariyah** (a
continuous charitable act) and fully open source.

---

## Why this exists

I spent years working on a project where code written by people I never met
kept running quietly, long after they'd moved on. Nobody remembered their
names. The code didn't care — it just kept working.

That question never left me: *what actually remains of the work, once
you're no longer in the room?*

Athar is my answer, built the only way I know how: not as a theory, but as
something running in a browser right now.

> **No screenshots in this README — deliberately.** The product changes
> weekly; screenshots rot and become lies. Open
> [openathar.org](https://openathar.org) instead — what's live is the
> honest documentation.

## What's actually live

The web frontend at [openathar.org](https://openathar.org) isn't a mockup —
these are real, working sections:

- **Two lights, one clock.** A 3D earth with a day/night terminator computed
  from today's actual solar position — not painted. The moon orbits at
  today's true elongation and shows today's real phase; a dedicated moon
  view lets you zoom in on it. Click anywhere on earth for prayer times at
  that spot, or open the dotted world map where day and night are live and
  every city carries its computed times.
- **The Written Book and the Witnessed Book.** The verse as it was revealed,
  and the world as it is measured — side by side, neither claiming to prove
  the other. Quran text is sourced and cited, never generated; every click
  loads a fresh verse/observation pair from the public API.
- **A calendar that stays quiet.** Today's Hijri date, upcoming Islamic
  events, and tonight's sky — moon phase, illumination, age — all computed,
  not fetched.

Fully trilingual — **DE / EN / AR**, with proper RTL for Arabic (logical
CSS, real webfont typography, no image-based lettering).

## The campaign: "Leave your Athar"

Aimed at open-source contributors: contribute code as a lasting good deed.
This is for developers who'd rather leave a Sadaqah Jariyah through code
than through a donation. No commercial product, no tracking, no ads — that's
the actual difference from Muslim Pro, Athan Pro, AlMosaly and the rest, not
just marketing language.

## Repositories (GitHub org: `openathar`)

| Repo | Purpose | Status |
|---|---|---|
| [`athar-web`](https://github.com/openathar/athar-web) | Next.js frontend — everything shown above | **Live, deployed** |
| [`athan-core-java`](https://github.com/openathar/athan-core-java) | Core SDK (Java 25 / Maven) — prayer times, Qibla, Hijri calculation | **Published to Maven Central** (`org.openathar:athan-core:0.1.0`) |
| [`api-service`](https://github.com/openathar/api-service) | Spring Boot backend, public REST API (rate-limited, cached) | **V1 live at `api.openathar.org`** — prayer times, Qibla, Hijri |
| [`athar-mobile-app`](https://github.com/openathar/athar-mobile-app) | iOS/Android app (offline-first) | **MVP built** (Expo) — native store builds pending |

> **Status: Pre-Alpha.** The web frontend is real and running, the
> calculation engine is published as a library on Maven Central, the
> public API serves its first endpoints, and the mobile app MVP is built
> (on the same calculation core via
> `@openathar/athan-core-ts`). See
> [`docs/architecture.md`](docs/architecture.md) for exactly what's built
> versus what's planned.

## Contributing

Contributors are welcome from MVP launch onward — that's the whole point of
"Leave your Athar". If you want to get involved earlier — architecture
feedback, religious content governance, licensing questions, translations —
open an issue right here.

Full system design & roadmap: [`docs/architecture.md`](docs/architecture.md).
Contributor notes for this superproject: [`AGENTS.md`](AGENTS.md).
