output "key_name" {
  description = "SSHキー名"
  value = compact(concat(
    aws_key_pair.imported.*.key_name,
    aws_key_pair.generated.*.key_name
  ))[0]
}
