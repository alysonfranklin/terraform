resource "aws_key_pair" "default"{
  key_name    = "zabbix" # O nome da sua chave na AWS
  public_key  = "${file("${var.key_path}")}" # Caminho para a chave publica ser exportada para AWS
}

resource "aws_instance" "instance" {
  ami                     = "${var.ami}" # ID da AMI
  instance_type           = "${var.instance_type}" # Tipo da instância (t2.micro, t3.small, etc.)
  count                   = "${var.instance_count}"
  key_name                = "${aws_key_pair.default.id}" # A chave publica será importada para a instância
  user_data               = "${file("${var.install_zabbix_server}")}" # Script para instalação do Zabbix
  vpc_security_group_ids  = ["${aws_security_group.default.id}"] 

  tags {
    Name  = "${var.instance_name}-${count.index + 1}" # Nome da instancia
  }
}
