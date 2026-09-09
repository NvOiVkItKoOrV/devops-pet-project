resource "yandex_vpc_security_group" "main" {
  name       = "devops-pet-sg"
  network_id = yandex_vpc_network.main.id
  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "TCP"
    port           = 6443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "TCP"
    from_port      = 2379
    to_port        = 2380
    v4_cidr_blocks = ["10.10.0.0/24"]
  }
  ingress {
    protocol       = "TCP"
    from_port      = 10250
    to_port        = 10259
    v4_cidr_blocks = ["10.10.0.0/24"]
  }
  ingress {
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "ANY"
    v4_cidr_blocks = ["10.10.0.0/24"]
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

}
