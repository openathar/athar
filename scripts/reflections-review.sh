#!/usr/bin/env bash
# Menschliche Freigabe für die KI-erzeugten Beobachtungen (ADR-002).
# Läuft auf dem Mac (kubectl-Kontext "prod"). Die KI-Validierung ist nur eine
# Vorprüfung — erst dieser Schritt macht einen Eintrag für Besucher sichtbar.
#
#   scripts/reflections-review.sh list              Entwürfe mit Text + KI-Urteil
#   scripts/reflections-review.sh promote <id> [name]   draft -> live
#   scripts/reflections-review.sh reject  <id> [name]   draft -> rejected
#   scripts/reflections-review.sh live              was Besucher gerade sehen
set -euo pipefail
CTX=${KUBE_CONTEXT:-prod}
psql_() { kubectl --context "$CTX" -n homelab exec -i homelab-pg-1 -c postgres -- psql -U postgres -d athar -v ON_ERROR_STOP=1 "$@"; }
need_id() { [[ "${1:-}" =~ ^[0-9]+$ ]] || { echo "usage: $0 $2 <id> [reviewer]" >&2; exit 2; }; }
who=${3:-${REVIEWER:-$(git config user.name 2>/dev/null || echo reviewer)}}

case "${1:-}" in
  list)
    psql_ -x -c "SELECT id, verse, field_en AS field, created_at::date AS created,
      observation_en AS en, observation_de AS de, observation_ar AS ar,
      validation->'verdict1'->>'valid' AS ki_1, validation->'verdict2'->>'valid' AS ki_2
      FROM reflections WHERE status='draft' ORDER BY id" ;;
  live)
    psql_ -c "SELECT id, verse, field_en, reviewed_by, reviewed_at::date FROM reflections WHERE status='live' ORDER BY id" ;;
  promote|reject)
    need_id "${2:-}" "$1"
    new=$([ "$1" = promote ] && echo live || echo rejected)
    # Prüfer-Name als psql-Variable (:'who'), nie in die SQL-Zeichenkette gebaut.
    # Per Stdin, weil `psql -c` keine Variablen interpoliert.
    psql_ -v who="$who" <<SQL
UPDATE reflections SET status='$new', reviewed_at=now(), reviewed_by=:'who'
 WHERE id=${2} AND status='draft' RETURNING id, verse, status, reviewed_by;
SQL
    ;;
  *) sed -n '2,10p' "$0"; exit 2 ;;
esac
