
variable "ssh_user" {}
variable "ssh_host" {}
variable "ssh_key" {}

# les variables ssh_host ssh_key ssh_user auront les valeurs qui se trouve dans dans le tfvars

# les variables sont passées dans notre module docker_intall

module "docker_install" {
	source = "./modules/docker_install/"
	ssh_host = var.ssh_host
	ssh_key = var.ssh_key
	ssh_user = var.ssh_user
}

module "docker_run_nginx" {
	source = "./modules/docker_run_nginx/"
	ssh_host = var.ssh_host
	ssh_key = var.ssh_key
	ssh_user = var.ssh_user
}