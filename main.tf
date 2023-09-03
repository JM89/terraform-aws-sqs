resource "aws_sqs_queue" "queue" {
  name                       = var.enable_fifo && !endswith(var.name, ".fifo") ? "${var.name}.fifo" : var.name
  kms_master_key_id          = aws_kms_key.queue_encryption_key.arn
  message_retention_seconds  = var.message_retention
  receive_wait_time_seconds  = var.long_polling_wait_time
  visibility_timeout_seconds = var.visibility_timeout
  delay_seconds              = var.delay
  fifo_queue                 = var.enable_fifo
  tags                       = var.tags
}

resource "aws_sqs_queue" "deadletter_queue" {
  count = var.enable_dlq ? 1 : 0
  name  = "${var.name}-dlq"
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.queue.arn]
  })
  kms_master_key_id          = aws_kms_key.queue_encryption_key.arn
  message_retention_seconds  = var.message_retention_dlq
  receive_wait_time_seconds  = var.long_polling_wait_time
  visibility_timeout_seconds = var.visibility_timeout
  delay_seconds              = var.delay
  tags                       = var.tags
}

resource "aws_sqs_queue_redrive_policy" "queue_redrive" {
  count     = var.enable_dlq ? 1 : 0
  queue_url = aws_sqs_queue.queue.id
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter_queue[0].arn
    maxReceiveCount     = var.max_retry_attempts
  })
}

resource "aws_kms_key" "queue_encryption_key" {
  description             = "Encryption key for SQS ${var.name}"
  tags                    = var.tags
}

resource "aws_kms_alias" "queue_encryption_key" {
  name          = "alias/${var.name}-key"
  target_key_id = aws_kms_key.queue_encryption_key.key_id
}

data "aws_iam_policy_document" "default_receive_policy_document" {
  statement {
    sid = "ReceivePolicySqs"
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage"
    ]
    resources = [
      aws_sqs_queue.queue.arn
    ]
  }
  statement {
    sid = "ReceivePolicyKms"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
      "kms:Encrypt",
    ]
    resources = [
      aws_kms_key.queue_encryption_key.arn
    ]
  }
}

data "aws_iam_policy_document" "default_send_policy_document" {
  statement {
    sid = "SendPolicySqs"
    actions = [
      "sqs:SendMessage"
    ]
    resources = [
      aws_sqs_queue.queue.arn
    ]
  }
  statement {
    sid = "SendPolicyKms"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = [
      aws_kms_key.queue_encryption_key.arn
    ]
  }
}

data "aws_iam_policy_document" "default_replay_policy_document" {
  count = var.enable_dlq ? 1 : 0
  statement {
    sid = "SendPolicySqs"
    actions = [
      "sqs:SendMessage"
    ]
    resources = [
      aws_sqs_queue.queue.arn
    ]
  }
  statement {
    sid = "ReceivePolicySqs"
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage"
    ]
    resources = [
      aws_sqs_queue.deadletter_queue[0].arn
    ]
  }
  statement {
    sid = "ReplayPolicyKms"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
      "kms:Encrypt",
    ]
    resources = [
      aws_kms_key.queue_encryption_key.arn
    ]
  }
}
