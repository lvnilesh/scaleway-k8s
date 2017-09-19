provider "scaleway" {
  region       = "par1"
}

data "scaleway_image" "ubuntu" {
  architecture = "x86_64"
  name         = "Ubuntu Zesty"
}

resource "scaleway_server" "worker" {
  count = 2
  name  = "worker${count.index}"
  image = "${data.scaleway_image.ubuntu.id}"
  type  = "VC1S"
  state  = "running"

  /* volume {
    size_in_gb = 50
    type       = "l_ssd"
  } */
}

resource "scaleway_server" "master" {
  count = 1 
  name  = "master${count.index}"
  image = "${data.scaleway_image.ubuntu.id}"
  type  = "VC1S"
  state  = "running"

  /* volume {
    size_in_gb = 50
    type       = "l_ssd"
  } */
}

output "worker_private_ips" {
  value = ["${scaleway_server.worker.*.private_ips}"]
}

output "master_private_ips" {
  value = ["${scaleway_server.worker.*.private_ips}"]
}
