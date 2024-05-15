locals {
  run_at = formatdate("YYYY-MM-DD", timeadd(time_static.example.rfc3339, "16h"))
  end_at = formatdate("YYYY-MM-DD", timeadd(time_static.example.rfc3339, "48h"))
}

resource "time_static" "example" {}