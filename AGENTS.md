# AGENTS.md — Athar (openathar)

Non-Profit Sadaqah-Jariyah-Projekt: kostenlose, werbefreie, datenschutz-
freundliche islamische Plattform (Web/Android/iOS) + Public API. Vollständig
Open Source unter der GitHub-Org **`openathar`**. Kampagne: "Leave your
Athar" — Code als bleibende gute Tat.

## Verknuepfungen

- Repo-Regeln & Konventionen: `~/Development/harness/agents/business-repo.md`
- Repo-Landkarte: `~/Development/harness/docs/repo-map.md`
- AGENTS.md-Konvention ("Karte, nicht Handbuch"): `~/Development/harness/agents/agents-md-convention.md`
- Skills (global): `~/.agents/skills/`

Dieser Ordner ist der **Superproject-Ordner** (analog `business/wasilah`),
die eigentlichen Repos liegen unter der Org `openathar` und werden hier als
Git-Submodule eingebunden: `core/` → `athan-core-java`, `api/` →
`api-service`, `mobile/` → `athar-mobile-app`.

## Architektur & Roadmap

Vollstaendiges Systemdesign (Bounded Contexts, API-Design,
Mobile-Constraints, DevOps, Sprint-1-Plan, offene kritische Fragen):
[`docs/architecture.md`](docs/architecture.md).

## Besonderheiten

- `core/` (`athan-core-java`) ist die einzige Quelle der Berechnungslogik —
  wird server- UND clientseitig genutzt, niemals zweitimplementieren.
- Submodule-Disziplin: im Submodule-Ordner arbeiten, danach Pointer hier
  bumpen. Kein zusaetzlicher Top-Level-Clone.
