
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.0.11"
}


resource "aws_instance" "rstudio" {
  ami           = "${lookup(var.images, var.region)}"
  instance_type = "${var.instance_type}"

  security_groups = [
    "${aws_security_group.rstudio_security_group.name}",
  ]


  key_name = "${var.keypair_name}"

  associate_public_ip_address = true

  root_block_device {
    volume_size           = "${var.root_block_device_volume_size}"
    volume_type           = "${var.root_block_device_volume_type}"
    delete_on_termination = "${var.root_block_device_volume_delete_on_termination}"
  }

  tags = {
    Name = "Rstudio Server"
  }

  user_data = "apt-get update -y"


  provisioner "file" {
    connection {
      host        = "${aws_instance.rstudio.public_ip}"
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(var.private_key)}"
    }

    source      = "provisioners/"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    connection {
      host        = "${aws_instance.rstudio.public_ip}"
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(var.private_key)}"
    }

    inline = [
      "sudo sh /tmp/provision.sh ${var.rstudio_password}",
    ]
  }

}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  max_allocated_storage = 100
  engine               = "postgres"
  engine_version       = "${var.postgres_version}"
  instance_class       = "db.t3.micro"
  name                 = "${var.postgres_database}"
  username             = "${var.postgres_username}"
  password             = "${var.postgres_password}"
}

resource "aws_eip" "rstudio_eip" {
  instance = "${aws_instance.rstudio.id}"
}
