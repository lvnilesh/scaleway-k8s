provider "scaleway" {
  region       = "par1"
}

data "scaleway_image" "ubuntu" {
  architecture = "x86_64"
  name         = "Ubuntu Xenial"
}

resource "scaleway_server" "server1" {
  name  = "server1"
  image = "${data.scaleway_image.ubuntu.id}"
  type  = "VC1S"
  state  = "running"

  volume {
    size_in_gb = 50
    type       = "l_ssd"
  }
}


