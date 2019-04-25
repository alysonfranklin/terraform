variable "aws_region" {
  description = "AWS region on which we will setup the swarm cluster"
  default = "us-east-1"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default     = "ami-028d6461780695a43" # Ubuntu 16 LTS
  #default     = "ami-4fffc834" # CentOS
}

variable "instance_type" {
  description = "Tipo da instância"
  default     = "t3.micro"
}

variable "key_path" {
  description = "Chave publica"
  default     = "~/.ssh/id_rsa.pub"
}

variable "install_zabbix_server" {
  description = "Script para instalação do Docker"
  default     = "install_zabbix_server.sh"
}

variable "instance_name" {
  description = "Qual será o nome da instancia?\nEx.: Zabbix_Server"
}

variable "sg_name" {
  description = "Informe o nome do SecurityGroup a ser criado\nEx.: sg_zabbix-server"
}

variable "instance_count" {
  description = "Quantas maquinas você deseja criar?\nEx.: 5"
}
