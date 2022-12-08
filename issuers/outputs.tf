output "cert_pem" {
  value = tls_self_signed_cert.trustanchor_cert.cert_pem
}

output "issuer_cert_validity_end_time" {
  value = tls_locally_signed_cert.issuer_cert.validity_end_time
}

output "issuer_cert_pem" {
  value = tls_locally_signed_cert.issuer_cert.cert_pem
}

output "issuer_key_pem" {
  value     = tls_private_key.issuer_key.private_key_pem
  sensitive = true
}