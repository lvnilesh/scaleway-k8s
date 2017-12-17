provider "scaleway" {
  region = "${var.region}"
}

data "scaleway_image" "ubuntu" {
  architecture = "${var.architecture}"
  name         = "${var.image}"
}

resource "scaleway_ip" "public_ip" {
  count = 1
}

resource "scaleway_server" "worker" {
  count  = "${var.worker_instance_count}"
  name   = "worker${count.index}"
  image  = "${data.scaleway_image.ubuntu.id}"
  type   = "${var.worker_instance_type}"
  state  = "running"
  tags   = ["workers"]

  volume {
    size_in_gb = 50
    type       = "l_ssd"
  }
}

resource "scaleway_server" "master" {
  count  = "${var.master_instance_count}"
  name   = "master${count.index}"
  image  = "${data.scaleway_image.ubuntu.id}"
  type   = "${var.master_instance_type}"
  state  = "running"
  tags   = ["masters"]
}

resource "scaleway_server" "proxy0" {
  count = 1
  name  = "proxy0"
  image = "${data.scaleway_image.ubuntu.id}"
  type  = "${var.proxy_instance_type}"
  public_ip  = "${element(scaleway_ip.public_ip.*.ip, count.index)}"
  state  = "running"
  tags  = ["proxy","primary"]
}

resource "scaleway_server" "proxy1" {
  count = 1
  name  = "proxy1"
  image = "${data.scaleway_image.ubuntu.id}"
  type  = "${var.proxy_instance_type}"
  state  = "running"
  tags  = ["proxy","secondary"]
}

output "worker_private_ips" {
  value = ["${scaleway_server.worker.*.private_ip}"]
}

output "master_private_ips" {
  value = ["${scaleway_server.master.*.private_ip}"]
}

output "proxy0_private_ips" {
  value = ["${scaleway_server.proxy0.*.private_ip}"]
}

output "proxy1_private_ips" {
  value = ["${scaleway_server.proxy1.*.private_ip}"]
}

output "public_ip" {
  value = ["${scaleway_server.proxy0.*.public_ip}"]
}
