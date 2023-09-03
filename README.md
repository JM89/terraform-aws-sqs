# terraform-aws-sqs

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.queue_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.queue_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_sqs_queue.deadletter_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_redrive_policy.queue_redrive](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_redrive_policy) | resource |
| [aws_iam_policy_document.default_receive_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.default_replay_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.default_send_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delay"></a> [delay](#input\_delay) | Delay in seconds. | `number` | `30` | no |
| <a name="input_enable_dlq"></a> [enable\_dlq](#input\_enable\_dlq) | Create an DLQ and redrive policy. | `bool` | `true` | no |
| <a name="input_enable_fifo"></a> [enable\_fifo](#input\_enable\_fifo) | Create a FIFO queue | `bool` | `false` | no |
| <a name="input_long_polling_wait_time"></a> [long\_polling\_wait\_time](#input\_long\_polling\_wait\_time) | Long polling Receive Wait Time in seconds. If 0, long-polling is disabled | `number` | `10` | no |
| <a name="input_max_retry_attempts"></a> [max\_retry\_attempts](#input\_max\_retry\_attempts) | Max number of attempt before DLQ-ing. Used only if `enable_dlq` is `true`. | `number` | `5` | no |
| <a name="input_message_retention"></a> [message\_retention](#input\_message\_retention) | Message Retention in seconds. | `number` | `86400` | no |
| <a name="input_message_retention_dlq"></a> [message\_retention\_dlq](#input\_message\_retention\_dlq) | Message Retention in seconds in DLQ. Used only if `enable_dlq` is `true`. | `number` | `86400` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the SQS resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | List of custom tags | `map` | `{}` | no |
| <a name="input_visibility_timeout"></a> [visibility\_timeout](#input\_visibility\_timeout) | Visibility timeout in seconds. | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_receive_policy_document"></a> [default\_receive\_policy\_document](#output\_default\_receive\_policy\_document) | n/a |
| <a name="output_default_replay_policy_document"></a> [default\_replay\_policy\_document](#output\_default\_replay\_policy\_document) | n/a |
| <a name="output_default_send_policy_document"></a> [default\_send\_policy\_document](#output\_default\_send\_policy\_document) | n/a |
| <a name="output_queue_arn"></a> [queue\_arn](#output\_queue\_arn) | n/a |
| <a name="output_queue_dlq_arn"></a> [queue\_dlq\_arn](#output\_queue\_dlq\_arn) | n/a |
<!-- END_TF_DOCS -->