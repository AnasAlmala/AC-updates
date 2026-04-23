#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# Default schedule target: 08:00 Asia/Riyadh == 05:00 UTC
DASH_DATE="${DASH_DATE:-$(date -u +%F)}"
OUT_FILE="docs/daily/dashboard_${DASH_DATE}.md"
TEMPLATE="docs/templates/daily_dashboard_template_ar.md"

mkdir -p docs/daily

if [[ ! -f "$TEMPLATE" ]]; then
  echo "Template not found: $TEMPLATE" >&2
  exit 1
fi

content="$(cat "$TEMPLATE")"
content="${content//\{\{DATE\}\}/$DASH_DATE}"
content="${content//\{\{TOP_OPPORTUNITY\}\}/${TOP_OPPORTUNITY:-TBD}}"
content="${content//\{\{TOP_CFP\}\}/${TOP_CFP:-TBD}}"
content="${content//\{\{TOP_ACTION\}\}/${TOP_ACTION:-Draft 150-word abstract}}"

for i in 1 2 3; do
  item_var="ITEM_${i}"; item_val="${!item_var:-TBD}"
  imp_var="IMP_${i}"; imp_val="${!imp_var:-Medium}"
  phd_var="PHD_${i}"; phd_val="${!phd_var:-High}"
  dec_var="DEC_${i}"; dec_val="${!dec_var:-Track}"
  next_var="NEXT_${i}"; next_val="${!next_var:-Set concrete next step}"

  content="${content//\{\{ITEM_${i}\}\}/$item_val}"
  content="${content//\{\{IMP_${i}\}\}/$imp_val}"
  content="${content//\{\{PHD_${i}\}\}/$phd_val}"
  content="${content//\{\{DEC_${i}\}\}/$dec_val}"
  content="${content//\{\{NEXT_${i}\}\}/$next_val}"
done

printf '%s\n' "$content" > "$OUT_FILE"
cp "$OUT_FILE" docs/daily/latest.md

echo "Generated: $OUT_FILE"
