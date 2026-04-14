# AC-updates

## Daily automation

Yes — updates can be fully automatic **daily** once GitHub Actions is enabled in the repository.

### What is automated now
- A scheduled workflow runs every day at **05:00 UTC** (which is **08:00 Asia/Riyadh**).
- It generates a daily dashboard file at `docs/daily/dashboard_YYYY-MM-DD.md`.
- It updates `docs/daily/latest.md`.
- If content changed, it commits and pushes automatically.

### Files
- Workflow: `.github/workflows/daily-academic-update.yml`
- Generator script: `scripts/daily_update.sh`
- Dashboard template: `docs/templates/daily_dashboard_template_ar.md`

### Notes
- Current generation is a scaffold/template-based automation.
- To make it data-driven, wire your collection sources into `scripts/daily_update.sh`.
