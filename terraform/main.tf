resource "yandex_vpc_network" "net" {
  name = "devops-net"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "devops-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_compute_instance" "vm" {
  count = 3

  name = element(["k8s-master", "k8s-app", "srv"], count.index)

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8s5s9gei5cqi6dvjmv"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }

  scheduling_policy {
    preemptible = true
  }
}

output "k8s_master_ip" {
  value = yandex_compute_instance.vm[0].network_interface.0.nat_ip_address
}

output "k8s_app_ip" {
  value = yandex_compute_instance.vm[1].network_interface.0.nat_ip_address
}

output "srv_ip" {
  value = yandex_compute_instance.vm[2].network_interface.0.nat_ip_address
}
