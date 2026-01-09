resource "aws_instance" "jumphost" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.lab_sg.id]
  iam_instance_profile   = var.lab_instance_profile

  root_block_device {
    volume_size = 30
  }

  user_data = templatefile("./install-tools.sh", {})

  tags = {
    Name = var.instance_name
  }
}
