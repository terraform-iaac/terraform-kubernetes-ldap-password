terraform {
  required_version = ">= 1.0.0"

  required_providers {
    kubernetes = ">= 2.17.0"
    helm       = ">= 2.8.0"
  }
}