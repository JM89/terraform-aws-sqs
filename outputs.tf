output "queue_arn" {
  value = aws_sqs_queue.queue.arn
}

output "queue_dlq_arn" {
  value = var.enable_dlq ? aws_sqs_queue.deadletter_queue[0].arn : ""
}

output "default_receive_policy_document" {
  value = data.aws_iam_policy_document.default_receive_policy_document.json
}

output "default_send_policy_document" {
value = data.aws_iam_policy_document.default_send_policy_document.json
}

output "default_replay_policy_document" {
  value = var.enable_dlq ? data.aws_iam_policy_document.default_replay_policy_document[0].json : ""
}