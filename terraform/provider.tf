terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  service_account_key_file = "authorized_key.json"
  cloud_id                 = "b1ghf2k3nmain9hk0gt4"
  folder_id                = "b1gkbh3mghau0kvdqslu"
  zone                     = "ru-central1-a"
}
