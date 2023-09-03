output "queue_arn" {
  value = module.fifo.queue_arn
}

output "default_receive_policy_document" {
  value = module.fifo.default_receive_policy_document
}

output "default_send_policy_document" {
value = module.fifo.default_send_policy_document
}