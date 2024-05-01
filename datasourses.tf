data "google_compute_instance_group" "node_instance_groups" {
  self_link = google_container_cluster.demo.node_pool[0].managed_instance_group_urls[0]
}

data "google_compute_instance" "nodes" {
  for_each = toset(data.google_compute_instance_group.node_instance_groups.instances[*])
  self_link = each.key
}

output "node_ip" {
  value = [for node in data.google_compute_instance.nodes : node.network_interface[0].access_config[0].nat_ip]
}