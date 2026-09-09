data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "vm" {
  for_each = toset(["master", "worker1", "worker2"])
  name     = "k8s-${each.key}"
  zone     = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.main.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.main.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(pathexpand("~/.ssh/devops-pet.pub"))}"
  }
}
