-- Schema der Datenbank `athar` (CNPG-Cluster homelab-pg, ns homelab).
-- Zweck: Vers + neutrale Naturbeobachtung für "The Written Book and the
-- Witnessed Book". Siehe docs/decisions/ADR-002-reflections-content-pipeline.md.
--
-- Statusfluss:  draft --(menschliche Freigabe)--> live
--               draft --(menschliche Ablehnung)--> rejected
-- Der n8n-Workflow schreibt NUR `draft`. Nur `live` erreicht Besucher.
-- Die KI-Validierung (validation) ist eine Vorprüfung, keine Freigabe.

CREATE TABLE IF NOT EXISTS reflections (
  id             BIGSERIAL PRIMARY KEY,
  verse          TEXT NOT NULL,              -- "36:38", Text kommt live aus quran.com
  field_de       TEXT NOT NULL,
  field_en       TEXT NOT NULL,
  field_ar       TEXT NOT NULL,
  topic          TEXT,                       -- Naturthema, das das Modell bekam (nie der Vers)
  observation_de TEXT NOT NULL,
  observation_en TEXT NOT NULL,
  observation_ar TEXT NOT NULL,
  status         TEXT NOT NULL DEFAULT 'draft',
  draft_model    TEXT,
  validation     JSONB,                      -- {verdict1, verdict2} der zwei KI-Schleifen
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  reviewed_at    TIMESTAMPTZ,
  reviewed_by    TEXT
);

-- Neu (2026-11-16): nur bekannte Status zulassen.
ALTER TABLE reflections DROP CONSTRAINT IF EXISTS reflections_status_chk;
ALTER TABLE reflections ADD CONSTRAINT reflections_status_chk
  CHECK (status IN ('draft', 'live', 'rejected'));

-- Eine Freigabe/Ablehnung ohne Prüfer + Zeitpunkt ist nicht zulässig.
ALTER TABLE reflections DROP CONSTRAINT IF EXISTS reflections_review_chk;
ALTER TABLE reflections ADD CONSTRAINT reflections_review_chk
  CHECK (status = 'draft' OR (reviewed_at IS NOT NULL AND reviewed_by IS NOT NULL));

CREATE INDEX IF NOT EXISTS reflections_live_idx ON reflections (id) WHERE status = 'live';
