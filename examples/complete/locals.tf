locals {
  run_at = formatdate("YYYY-MM-DD", timeadd(timestamp(), "16h"))
  end_at = formatdate("YYYY-MM-DD", timeadd(timestamp(), "48h"))
}