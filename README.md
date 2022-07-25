# literate-umbrella
------
This is an evolution of the [space-monkey](https://github.com/james-cole2015/space-monkey.git) repo. While this shares the same overall purpose of spinning up a webserver, this repo has a different goal in mind. The work in this repo will be focused on created an auto-scaling group that spins up servers that serve the Cody's Corner content. This will have similiarities in that the modules that house the VPC and key pairs are shared from that repo. Also, I will create an additional autoscaling group for the bastion hosts. The goal is to create dynamic connections that allow the webservers to host content and only be remotely accessible from the bastion hosts. 

## Repo Goals
- [X] Add auto scaling group for webserver
- [X] Add auto scaling group for bastion host
- [X] Add elastic load balancer for webserver
- [ ] ~~Add security group to webserver to allow access only from bastion host~~
- [ ] ~~Add security group to bastion host to only allow access from terraform server~~ 

## High Level Commits 
- Created launch configuration and autoscaling group for webserver
- Added security groups that allow SSH, HTTP, HTTPS
- Added SSH key to remotely access
- Added launch template for webserver 
- Added launch template for bastion host 
- Added auto scaling group for bastion host
- Added load balancer, target group, & listener


![Final Architecture Diagram](https://github.com/james-cole2015/literate-umbrella/blob/main/literate-umbrella_final.jpg)[^1]
[^1]: [Image generated from Terraform Visual](https://hieven.github.io/terraform-visual/)
