locals {
  run_at                   = formatdate("YYYY-MM-DD", timeadd(time_static.example.rfc3339, "16h"))
  end_at                   = formatdate("YYYY-MM-DD", timeadd(time_static.example.rfc3339, "48h"))
  scaling_simple_rule_name = "tf-testAccScalingSimpleRule-${random_integer.default.result}"
}

resource "time_static" "example" {}