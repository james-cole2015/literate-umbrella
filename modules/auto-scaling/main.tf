data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
/*
resource "aws_launch_configuration" "asg_config" {
  name_prefix   = "${var.repo-name}-instance-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  user_data     = file("ws_bootstrap.sh")
  security_groups = var.security_group
  key_name = var.key_name


  lifecycle {
    create_before_destroy = true
  }
}
*/

## Launch Template
resource "aws_launch_template" "lu-launch-template" {
  name = "${var.repo-name}-launch-template"

  credit_specification {
    cpu_credits = "standard"
  }

  image_id = data.aws_ami.ubuntu.id 
  instance_type = var.instance-type
  key_name = var.key_name
  #monitoring = true
  vpc_security_group_ids = var.security_group

  user_data = filebase64("ws_bootstrap.sh")

  tag_specifications {
    resource_type = "instance" 

    tags = {
      Name = "${var.repo-name}-webserver"
      environment = "dev"
      platform = "terraform"
    }
  }
}


## Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  name                 = "${var.repo-name}-asg"
  #launch_configuration = aws_launch_configuration.asg_config.name
  min_size             = 2
  max_size             = 3
  vpc_zone_identifier  = [var.subnet_id]

  lifecycle {
    create_before_destroy = true
  }

  launch_template {
    id = aws_launch_template.lu-launch-template.id
    version = "$Latest"
  }
}