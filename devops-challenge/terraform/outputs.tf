output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.simple.dns_name
}

output "alb_url" {
  description = "URL of the ALB"
  value       = "http://${aws_lb.simple.dns_name}"
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.simple_time.repository_url
}
