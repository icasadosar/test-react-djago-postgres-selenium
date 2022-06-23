# Provisions a spot EC2 instance with Centos 7.4 image
# Zone for AMI is us-east-1

provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "test-spot" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "subnet-test-spot" {
  # creates a subnet
  cidr_block        = "${cidrsubnet(aws_vpc.test-spot.cidr_block, 3, 1)}"
  #cidr_block        = "10.0.1.0/24"
  vpc_id            = "${aws_vpc.test-spot.id}"
  availability_zone = "eu-west-1a"
}

resource "aws_security_group" "ingress-ssh-test" {
  name   = "allow-ssh-sg"
  vpc_id = "${aws_vpc.test-spot.id}"

  ingress {
    cidr_blocks = [
      "79.116.135.184/32"
    ]

    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ingress-http-test" {
  name   = "allow-http-sg"
  vpc_id = "${aws_vpc.test-spot.id}"

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ingress-https-test" {
  name   = "allow-https-sg"
  vpc_id = "${aws_vpc.test-spot.id}"

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 443
    to_port   = 443
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "ip-test-env" {
  instance = "${aws_spot_instance_request.test_worker.spot_instance_id}"
  vpc      = true
}

resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = "${aws_vpc.test-spot.id}"
}

resource "aws_route_table" "route-table-test-env" {
  vpc_id = "${aws_vpc.test-spot.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test-env-gw.id}"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.subnet-test-spot.id}"
  route_table_id = "${aws_route_table.route-table-test-env.id}"
}

resource "aws_key_pair" "spot_key" {
  key_name   = "spot_key"
  public_key = "${file("/home/ics/.ssh/id_rsa.pub")}"
}

resource "aws_spot_instance_request" "test_worker" {
  ami                    = "ami-0d71ea30463e0ff8d"
  spot_price             = "0.016"
  instance_type          = "t2.small"
  spot_type              = "one-time"
  #block_duration_minutes = "120"
  wait_for_fulfillment   = "true"
  key_name               = "spot_key"
  #user_data              = "local.ec2_user_data" # no forces replacement
  #user_data_replace_on_change = "false"

  lifecycle {
    ignore_changes = [user_data]
  }

  # no forces replacement
  vpc_security_group_ids = ["${aws_security_group.ingress-ssh-test.id}", "${aws_security_group.ingress-http-test.id}",
  "${aws_security_group.ingress-https-test.id}"]
  subnet_id = "${aws_subnet.subnet-test-spot.id}"

  user_data = <<-EOF
	      #!/bin/bash
        sudo amazon-linux-extras enable nginx1
        sudo yum clean metadata
        sudo yum -y install nginx
        sudo service nginx start
        sudo mv /usr/share/nginx/html/ /usr/share/nginx/html_default
        sudo mkdir /usr/share/nginx/html/
        sudo chown nginx:nginx /usr/share/nginx/html/
        sudo chmod 755 /usr/share/nginx/html/
		    echo "Hello world from EC2 $(hostname -f) primera prueba terraform" > /usr/share/nginx/html/index.html
        sudo chown nginx:nginx -R /usr/share/nginx/html/*
        sudo chmod 644 /usr/share/nginx/html/*
		    EOF

  tags = {
    Name = "ec2-test-ngnx-terraform"
  }

}

output "instance_ip_public" {
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_spot_instance_request.test_worker.public_ip}"
}

output "endpoint_https" {
  value = "https://${aws_spot_instance_request.test_worker.public_ip}/index.html"
}
