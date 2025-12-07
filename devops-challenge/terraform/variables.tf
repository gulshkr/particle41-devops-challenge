variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "image_url" {
  description = "URL of the Docker image to deploy"
  type        = string
}
