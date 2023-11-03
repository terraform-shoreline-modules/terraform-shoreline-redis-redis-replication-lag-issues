resource "shoreline_notebook" "redis_replication_lag_issues" {
  name       = "redis_replication_lag_issues"
  data       = file("${path.module}/data/redis_replication_lag_issues.json")
  depends_on = [shoreline_action.invoke_update_redis_buffer_size]
}

resource "shoreline_file" "update_redis_buffer_size" {
  name             = "update_redis_buffer_size"
  input_file       = "${path.module}/data/update_redis_buffer_size.sh"
  md5              = filemd5("${path.module}/data/update_redis_buffer_size.sh")
  description      = "Increase the replication buffer size to reduce the number of missed commands."
  destination_path = "/tmp/update_redis_buffer_size.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_redis_buffer_size" {
  name        = "invoke_update_redis_buffer_size"
  description = "Increase the replication buffer size to reduce the number of missed commands."
  command     = "`chmod +x /tmp/update_redis_buffer_size.sh && /tmp/update_redis_buffer_size.sh`"
  params      = ["NEW_BUFFER_SIZE","REDIS_CONF_FILE_PATH"]
  file_deps   = ["update_redis_buffer_size"]
  enabled     = true
  depends_on  = [shoreline_file.update_redis_buffer_size]
}

