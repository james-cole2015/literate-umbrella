data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_configuration" "asg_config" {
    name_prefix = "${var.repo-name}-instance-"
    image_id = data.aws_ami.ubuntu.id
    instance_type = var.instance-type

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_auto_scaling_group" "asg" {
    name = "${var.repo-name}-asg"
    launch_configuration = aws_launch_configuration.asg_config.name
    min_size = 1
    max_size = 2

    lifecycle {
        create_before_destroy = true
    }
}