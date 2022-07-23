data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = "${var.repo-name}-bastion-host-asg"
  #launch_configuration = aws_launch_configuration.asg_config.name
  min_size             = 1
  max_size             = 2
  vpc_zone_identifier  = [var.subnet_id]

  lifecycle {
    create_before_destroy = true
  }

  launch_template {
    id = aws_launch_template.bastion-host-launch-template.id
    version = "$Latest"
  }
}

## Bastion Host Launch Template
resource "aws_launch_template" "bastion-host-launch-template" {
  name = "${var.repo-name}-bastion-host-LT"

  credit_specification {
    cpu_credits = "standard"
  }

  image_id = data.aws_ami.ubuntu.id 
  instance_type = var.instance-type
  key_name = var.key_name
  ## Remember to update this
  vpc_security_group_ids = var.security_group

  #user_data = filebase64("ws_bootstrap.sh")

  tag_specifications {
    resource_type = "instance" 

    tags = {
      Name = "${var.repo-name}-bastion-host"
      environment = "dev"
      platform = "terraform"
    }
  }
}

