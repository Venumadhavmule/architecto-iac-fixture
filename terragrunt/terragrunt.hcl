terraform {
  source = "../terraform/modules/network"
}

dependency "root" {
  config_path = "../terraform"
}

inputs = {
  project_name = "architecto-fixture"
  cidr_block   = "10.42.0.0/16"
}
