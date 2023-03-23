
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

resource "null_resource" "ssh_target_host" {
	connection {
		type = "ssh"
		user = var.ssh_user
		host = var.ssh_host
		private_key = file(var.ssh_key)
	}
	provisioner "remote-exec" {
		inline = [
			"sudo mkdir -p /home/vagrant/_data_docker/",
			"sudo chmod 777 -R /home/vagrant/_data_docker/",
			"sleep 5s"
		]
	}
}

provider "docker" {
	host = "tcp://${var.ssh_host}:2375"
}

resource "docker_volume" "myvolume" {
	name = "myvolume"
	driver = "local"
	driver_opts = {
		o = "bind"
		type = "none"
		device = "/home/vagrant/_data_docker/"
	}
	depends_on = [ null_resource.ssh_target_host ]
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "enginecks"
  ports {
    internal = 80
    external = 80
  }
  
  volumes {
	volume_name = docker_volume.myvolume.name
	container_path = "/usr/share/nginx/html/"
  }
}