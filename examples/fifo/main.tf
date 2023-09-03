module "fifo" {
  source      = "../.."
  name        = "fifo-queue"
  enable_fifo = true
  enable_dlq  = false
}