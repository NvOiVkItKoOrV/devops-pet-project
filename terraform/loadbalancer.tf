resource "yandex_lb_target_group" "k8s_nodes" {
  name = "k8s-nodes-tg"

  target {
    subnet_id = yandex_vpc_subnet.main.id
    address   = yandex_compute_instance.vm["master"].network_interface[0].ip_address
  }
  target {
    subnet_id = yandex_vpc_subnet.main.id
    address   = yandex_compute_instance.vm["worker1"].network_interface[0].ip_address
  }
  target {
    subnet_id = yandex_vpc_subnet.main.id
    address   = yandex_compute_instance.vm["worker2"].network_interface[0].ip_address
  }
}

resource "yandex_lb_network_load_balancer" "k8s_lb" {
  name = "k8s-ingress-lb"

  listener {
    name = "http"
    port = 80
    target_port = 31468
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  listener {
    name = "https"
    port = 443
    target_port = 31287
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.k8s_nodes.id

    healthcheck {
      name = "http-health"
      http_options {
        port = 31468
        path = "/healthz"
      }
    }
  }
}

