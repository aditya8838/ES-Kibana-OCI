terraform {
  backend "s3" {
    bucket  = "es-kibana-oci"
    key     = "terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
