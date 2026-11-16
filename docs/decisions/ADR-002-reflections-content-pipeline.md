# ADR-002: Reflections-Inhalte — n8n-Generierung + AI-Vorprüfung + Postgres + menschliche Freigabe

## Status
Accepted

## Date
2026-11-16

## Context

Der Abschnitt „The Written Book and the Witnessed Book" (Vers + neutrale
Naturbeobachtung) auf der Landingpage braucht frische, dynamische Inhalte.
Bisher liegen alle Paare statisch in `web/data/reflections.json` (18 Einträge,
per Klick zufällig ausgewählt). Neue Inhalte erforderten bislang manuelles
Schreiben + redaktionelle Prüfung.

`architecture.md` (offene Frage #1) hält fest: KI-verfasster Beobachtungstext
braucht eine menschliche Freigabe (arabisch aktuell `arabicApproved: false`).
Der bestehende Generator `web/scripts/generate-reflections.mjs` verankert ein
Sicherheitsprinzip: das Modell bekommt **nur das Naturthema, nie den Vers**, und
schreibt ausschließlich Entwürfe.

## Decision

1. **Speicherung in Postgres** — neue Datenbank `athar` im bestehenden
   CNPG-Cluster `homelab-pg` (ns `homelab`), nicht als neues Cluster (ein
   eigenes CNPG-Cluster kommt erst mit User-Sync/Khatma, siehe
   `architecture.md`). Tabelle `reflections` mit Statusfluss:
   `draft` → (menschliche Freigabe) → `live`.
2. **Generierung + AI-Validierung via n8n + OpenRouter** — ein Workflow
   (`athar: Reflections generieren + islamisch validieren`) erzeugt die
   Beobachtung (Sonnet) und validiert sie in zwei Schleifen (Haiku) gegen
   feste Regeln: keine religiöse Deutung, kein „Vers beweist Wissenschaft",
   nur Lehrbuchwissen, zwei Sätze, neutral. Das Sicherheitsprinzip bleibt:
   das Modell erhält nur das Naturthema, nie den Vers.
3. **AI-Validierung ist eine technische Vorprüfung, keine Freigabe** — der
   letzte Gate bleibt menschlich (redaktionell bzw. Ijazah-geprüft). Ein
   AI-Loop ersetzt das nicht.
4. **Web liest nur `live`** — `/api/reflections` bedient sich aus dem
   Live-Pool, mit `reflections.json` als Seed/Fallback, solange der Pool leer
   ist oder die DB nicht erreichbar ist.

## Consequences

- Neue Rolle + Datenbank + Tabelle in `homelab-pg`; Registrierung in pgAdmin
  (Skill `pgadmin-sync`).
- DB-Zugangsdaten für n8n (schreiben) und Web (lesen) über die üblichen
  Secret-Wege (Vault + External Secrets bzw. k8s-Secret), nie in Git.
- Die Verse bleiben aus quran.com (exakt), nie vom Modell erzeugt.
- Menschliche Freigabe bleibt Pflicht: ein validierter `draft` wird erst nach
  menschlicher Sichtung `live`.
