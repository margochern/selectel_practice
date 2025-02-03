output "server_outputs" {
  value = [
    "ssh -i ./keys root@${module.todo.floating_ip}",
    "ssh -i ./keys root@${module.db_server.floating_ip}"
  ]
}