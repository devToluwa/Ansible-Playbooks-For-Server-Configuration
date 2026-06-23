output "webserver_public_ips" {
  description = "Public IPs of the web servers"
  value       = aws_instance.webservers[*].public_ip
}

output "dbserver_public_ip" {
  description = "Public IP of the database server"
  value       = aws_instance.dbserver.public_ip
}