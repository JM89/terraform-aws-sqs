variable "name" {
  description = "Name of the SQS resource."
  type        = string
  validation {
    condition     = length(var.name) <= 76
    error_message = "The variable `name` should not exceed 76 characters."
  }
}

variable "enable_dlq" {
  description = "Create an DLQ and redrive policy."
  type        = bool
  default     = true
}

variable "max_retry_attempts" {
  description = "Max number of attempt before DLQ-ing. Used only if `enable_dlq` is `true`."
  type        = number
  default     = 5
}

variable "tags" {
  description = "List of custom tags"
  type        = map
  default     = {}
}

variable "message_retention" {
  description = "Message Retention in seconds."
  type        = number
  default     = 86400
}

variable "message_retention_dlq" {
  description = "Message Retention in seconds in DLQ. Used only if `enable_dlq` is `true`."
  type        = number
  default     = 86400
}

variable "long_polling_wait_time" {
  description = "Long polling Receive Wait Time in seconds. If 0, long-polling is disabled"
  type        = number
  default     = 10
}

variable "visibility_timeout" {
  description = "Visibility timeout in seconds."
  type        = number
  default     = 30
}

variable "delay" {
  description = "Delay in seconds."
  type        = number
  default     = 30
}

variable "enable_fifo" {
  description = "Create a FIFO queue"
  type        = bool
  default     = false
}