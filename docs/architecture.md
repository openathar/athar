# Athar — Systemdesign & Roadmap

## Domain-Driven Design & Bounded Contexts

| Context | Typ | Verantwortung |
|---|---|---|
| **Calculation Engine** (`athan-core-java`) | Core Domain | Gebetszeiten (MWL/ISNA/Umm Al-Qura...), Qibla, Hijri-Konvertierung — rein, zustandslos, kein DB-Zugriff |
| **Content Distribution** | Supporting | Quran, Hisn Al-Muslim, Ruqyah, Adhkar — versioniert, CDN-tauglich |
| **User Engagement / Sync** | Supporting | Khatma-Tracking, Tasbeeh-Counter, Ramadan-Dashboard — einziger Context mit echtem User-State |
| **Notification/Scheduling** | Supporting | Adhan-Trigger, lokale Alarme, Content-Push |
| **Public API Gateway** (`api-service`) | Open Host Service | Rate-Limiting, API-Keys, Developer-Portal — Wrapper um Calculation + Content |
| **Identity** | Generic, bewusst minimal | Kein Pflicht-Account fürs Grundprodukt — Device-ID + optionaler Pairing-Code |

**Kritische Entscheidung:** `athan-core-java` ist die **einzige Quelle der
Wahrheit** für die Berechnungslogik — client- (offline) und serverseitig
(Public API) identisch, kein Re-Implementieren. Kotlin-Multiplatform-fähig
halten (JVM für Backend, nativ für Mobile).

## Systemarchitektur & API-Design

- **Modularer Monolith** zu Beginn (Hexagonal, ein Modul pro Bounded
  Context), Microservices erst bei nachweisbarem Skalierungsdruck.
- **Public API**: Ergebnisse sind für (lat, lon, date, method) für immer
  gleich → aggressives HTTP-Caching (`Cache-Control: immutable`) + CDN-Edge
  davor. Rate-Limiting via Redis Token-Bucket pro API-Key + IP-Grundlimit
  für anonyme Nutzung (wie Aladhan-API).
- **Kein GraphQL für V1** — Datenmodelle sind flach, REST + Cache-Header
  reichen.
- **Sync-Strategie**: App rechnet Gebetszeiten immer lokal (embedded
  `athan-core-java`), Server nur für GPS→Standort-Auflösung. Nur
  Khatma-Fortschritt/Tasbeeh synchronisieren, ohne Pflicht-Account
  (Device-ID + optionaler Pairing-Code, Last-Write-Wins + monotoner Zähler).

## Mobile-Herausforderungen

- **Nicht auf Push für Adhan-Timing verlassen** (Doze Mode / iOS
  Background-Throttling unzuverlässig für Sekunden-genaue Trigger).
- Android: `WorkManager` berechnet N Tage voraus, `AlarmManager
  .setExactAndAllowWhileIdle` + explizite `SCHEDULE_EXACT_ALARM`-Permission
  (Android 12+) + Battery-Optimization-Exemption-Dialog.
- iOS: Lokale `UNUserNotificationCenter`-Notifications ~7 Tage im Voraus,
  Refresh via `BGAppRefreshTask`/`BGProcessingTask`. Live Activities als
  Timer-Style (fixes Enddatum) — kein periodischer Push nötig.
- Smart-Speaker-Integration (Alexa/Google Home) ist entkoppelt, ruft nur die
  Public API — kein Einfluss auf Mobile-Architektur.

## DevOps & Hosting (kosteneffizient)

- k3s/k3d (bestehendes Homelab-Setup) reicht für MVP.
- PostgreSQL via CNPG-Operator (User-Sync-Daten sind klein).
- Redis Single-Instance für Cache + Rate-Limiting.
- Statischer Content (Quran-Texte/Audio/Fonts) über Object Storage + CDN,
  **nicht** über App-Pods.
- Public-API-Erreichbarkeit über Cloudflare Tunnel; bei Wachstum kleiner
  VPS (Hetzner) als Ingress statt Home-Bandbreite.
- HPA nur auf API-Gateway-Pods, nicht auf Calculation Engine.

## Sprint 1 — MVP

**Backend (`api-service` + `athan-core-java`):**
1. Spring-Boot-Skeleton, nur Calculation-Engine-Modul (Hexagonal).
2. Algorithmus portieren (Referenz: PrayTimes.org-Spec), Unit-Tests gegen
   Referenzwerte.
3. Einziger Endpoint: `GET /v1/prayer-times?lat&lon&date&method`.
4. Redis-Cache + einfaches Rate-Limiting.
5. Deploy auf k3d-Stage.

**Mobile (`athar-mobile-app`):**
1. Flutter/KMP-Scaffold, Calculation-Logik direkt eingebettet.
2. Minimal-UI: heutige Gebetszeiten + Qibla-Kompass.
3. Lokale Adhan-Notification-Scheduling, Doze/Background-Test auf echtem
   Gerät.
4. Interner Alpha-Release.

## Offene kritische Fragen (vor Public Launch klären)

1. **Content-Governance**: Wer verifiziert Quran-Text/Hadith-Authentizität/
   madhhab-spezifische Methoden (Ijazah-Träger-Review-Prozess)?
2. **Nachhaltigkeit ohne Ads/Tracking**: Finanzierungsmodell für Infra
   (Sadaqah/Waqf/Sponsoring), ggf. Verein/Stiftung als Träger für
   SLA-Fähigkeit der Public API.
3. **Content-Lizenzierung**: Nutzungsrechte für Mushaf-Fonts, Rezitationen,
   Übersetzungen vor Integration klären.
