provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "ubuntu_22_latest" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "my_tf_ec2" {
  ami                    = data.aws_ami.ubuntu_22_latest.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ssh_ec2_key.id
  vpc_security_group_ids = [aws_security_group.my_sg_4_tf_ec2.id]
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = 8
    volume_type           = "standard"
    delete_on_termination = true
  }
  tags = {
    Name  = "my_tf_ec2"
    owner = "ninja"
  }
}

resource "aws_key_pair" "ssh_ec2_key" {
  key_name = "aws_ssh_key_pair"
  public_key = file("srv1.pub")
}

resource "aws_security_group" "my_sg_4_tf_ec2" {
  name        = "TF_SSH"
  description = "GS for Amazon test TF EC2"
  dynamic "ingress" {
    for_each = ["22", "80"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "my_tf_ec2_public_ip" {
  value = aws_instance.my_tf_ec2.public_ip
}

