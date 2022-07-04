terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.19.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      environment = "test"
      owner       = "devops"
      com         = "trak"
      project     = "apptest"
    }
  }
}

resource "aws_vpc" "test-spot" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = "${aws_vpc.test-spot.id}"
}

resource "aws_subnet" "subnet-test-spot" {
  # creates a subnet
  #cidr_block        = "${cidrsubnet(aws_vpc.test-spot.cidr_block, 3, 1)}"
  cidr_block        = "${var.subnet}"
  vpc_id            = "${aws_vpc.test-spot.id}"
  availability_zone = "eu-west-1a"

  depends_on = [aws_internet_gateway.test-env-gw]
}

resource "aws_eip" "ip-test-env" {
  vpc                       = true
  #instance                  = aws_spot_instance_request.test_worker.spot_instance_id
  #associate_with_private_ip = "${cidrhost(var.subnet, 5)}"
  #network_interface = "${element(aws_network_interface.eth-text.*.id, count.index)}"

  depends_on = [aws_internet_gateway.test-env-gw]
}

resource "aws_security_group" "ingress-ssh-test" {
  name   = "allow-ssh-sg"
  vpc_id = "${aws_vpc.test-spot.id}"

  ingress {
    cidr_blocks = [
      "${var.my-public-ip}/32"
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

/*
resource "aws_security_group" "ingress-http-test" {
  name   = "allow-http-sg"
  vpc_id = "${aws_vpc.test-spot.id}"

  ingress {
    cidr_blocks = [
      "${var.my-public-ip}/32"
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
      "${var.my-public-ip}/32"
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
*/

resource "aws_security_group" "ingress-vnc-test" {
  name   = "allow-vnc-sg"
  vpc_id = "${aws_vpc.test-spot.id}"

  ingress {
    cidr_blocks = [
      "${var.my-public-ip}/32"
    ]

    from_port = 5091
    to_port   = 5091
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ingress-rdp-test" {
  name   = "allow-rdp-sg"
  vpc_id = "${aws_vpc.test-spot.id}"

  ingress {
    cidr_blocks = [
      "${var.my-public-ip}/32"
    ]

    from_port = 3389
    to_port   = 3389
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
/*
resource "aws_network_interface" "eth-test" {
  subnet_id = "${aws_subnet.subnet.0.id}"
  description = "eth-test0${count.index}"

  security_groups = ["${aws_security_group.ingress-ssh-test.id}", "${aws_security_group.ingress-http-test.id}",
  "${aws_security_group.ingress-https-test.id}"]
}
*/

data "aws_secretsmanager_secret_version" "GIT_PASS" {
  secret_id     = "arn:aws:secretsmanager:eu-west-1:522192775665:secret:testapp/git/pass-QfhnRl"
  #sensitive     = "true" 
  #secret_string = aws_secretsmanager_secret_version.key-github.secret_string
}

locals {
  GIT_PASS = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.GIT_PASS.secret_string))["GIT_PASS"]
}

data "aws_secretsmanager_secret_version" "CONF_DB" {
  secret_id      = "arn:aws:secretsmanager:eu-west-1:522192775665:secret:pass_db_trakDb_test-7In7DX"
}

locals {
  PASS_DB = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.CONF_DB.secret_string))["pass_db_trakBack_test"]
}

locals {
  USER_DB = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.CONF_DB.secret_string))["user_db_trakBack_test"]
}

locals {
  NAME_DB = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.CONF_DB.secret_string))["name_db_trakBack_test"]
}

locals {
  HOST_DB = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.CONF_DB.secret_string))["host_db_trakBack_test"]
}

locals {
  PORT_DB = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.CONF_DB.secret_string))["port_db_trakBack_test"]
}

/*
locals {
  key-github = jsondecode(
    data.aws_secretsmanager_secret_version.creds-key-github.secret_string
  )
}
*/

resource "aws_spot_instance_request" "test_worker" {
  #count = "${var.something_count}"

  #ami                    = "ami-0d71ea30463e0ff8d" # Amazon Linux
  #ami                    = "ami-033657df95dbf281a" # Amazon Linux Desktop
  ami                    = "ami-0f68759fb5f855c36" # Trak Amazon Linux Desktop Test
  #spot_price             = "0.016"
  instance_type          = "${var.ec2_instance}"
  subnet_id              = aws_subnet.subnet-test-spot.id
  #private_ip             = "${cidrhost(var.subnet, 10)}"
  spot_type              = "one-time"
  wait_for_fulfillment   = "true"
  key_name               = "spot_key"
  #block_duration_minutes = "120"
  #user_data              = "local.ec2_user_data" # no forces replacement, only one in the file
  #user_data_replace_on_change = "false"

/*
  lifecycle {
    ignore_changes = [user_data]
  }
*/

  # no forces replacement
  vpc_security_group_ids = [aws_security_group.ingress-ssh-test.id, aws_security_group.ingress-vnc-test.id, aws_security_group.ingress-rdp-test.id]
/*
  network_interface {
    network_interface_id = "${element(aws_network_interface.eth-test.*.id, count.index)}"
    device_index = 0
  }
*/
/*
  connection {
    type          = "ssh"
    host          = self.public_ip
    user          = "ec2-user"
    private_key   = "${file("/home/ics/.ssh/id_rsa.pub")}"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install ansible2 -y",
      "sudo yum install git -y",
      "git clone https://github.com/icasadosar/prueba01 /tmp/ansible_playbooks",
      "ansible-playbook /tmp/ansible_playbooks/ansible/nginx.yml"
      ]
  }
*/

  user_data = <<-EOF
        #!/bin/bash
        #####sudo chmod 600 /home/ec2-user/.ssh/ssh-key-github
        mkdir /var/log/trak/
        chmod 755 /var/log/trak/
        echo "** start: terraform `date +%c` **" >> /var/log/trak/terraform.log
        sudo amazon-linux-extras install ansible2 -y
        #####ansible-galaxy collection install community.postgresql # dependecy error
        sudo yum update
        sudo yum install git -y
        #####sudo yum install jq -y
        echo "export GIT_PASS=${local.GIT_PASS}" >> /tmp/.env-var-git.sh
        echo "export PASS_DB=${local.PASS_DB}" >> /tmp/.env-var.sh
        echo "export USER_DB=${local.USER_DB}" >> /tmp/.env-var.sh
        echo "export NAME_DB=${local.NAME_DB}" >> /tmp/.env-var.sh
        echo "export HOST_DB=${local.HOST_DB}" >> /tmp/.env-var.sh
        echo "export PORT_DB=${local.PORT_DB}" >> /tmp/.env-var.sh
        echo "export GIT_BRANCH=${var.GIT_BRANCH}" >> /tmp/.env-var.sh
        source /tmp/.env-var.sh
        source /tmp/.env-var-git.sh
        cat /tmp/.env-var.sh >> /home/ec2-user/.bash_profile
        #rm /tmp/.env-var.sh
        #rm /tmp/.env-var-git.sh
        git clone https://github.com/icasadosar/prueba01 /tmp/ansible_playbooks
        #####ansible-playbook /tmp/ansible_playbooks/ansible/ansible.yml
        ansible-playbook /tmp/ansible_playbooks/ansible/nginx.yml
        ansible-playbook /tmp/ansible_playbooks/ansible/nodejs.yml
        ansible-playbook /tmp/ansible_playbooks/ansible/django.yml
        ansible-playbook /tmp/ansible_playbooks/ansible/postgresql.yml
        echo "** end: terraform `date +%c` **" >> /var/log/trak/terraform.log 2>&1
  EOF

/*
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
*/

  tags = {
    Name = "ec2-trak-test-ci-terraform"
  }

  depends_on = [aws_vpc.test-spot, aws_key_pair.spot_key, aws_security_group.ingress-ssh-test, aws_security_group.ingress-vnc-test, aws_security_group.ingress-rdp-test]

}

resource "aws_eip_association" "ip-test-env" {
  instance_id   = aws_spot_instance_request.test_worker.spot_instance_id
  allocation_id = aws_eip.ip-test-env.id

  ##### provisioner "file" {
  #####  #content       = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.creds-key-github.secret_string))
  #####  source        = "/home/ics/.ssh/id-key-github"                    
  #####  destination   = "/home/ec2-user/.ssh/ssh-key-github"

  #####  connection {
  #####    type        = "ssh"
  #####    user        = "ec2-user"
  #####    private_key = "${file("/home/ics/.ssh/id_rsa")}"
  #####    host        = aws_eip.ip-test-env.public_ip
  #####    timeout     = "30s"
  #####  }

  ##### }

}

/*
resource "ssh_resource" "init" {
  # The default behaviour is to run file blocks and commands at create time
  # You can also specify 'destroy' to run the commands at destroy time
  when = "create"

  host         = aws_eip.ip-test-env.public_ip
  #bastion_host = "bastion.host.com"
  user         = ec2-user
  #host_user    = var.host_user
  #agent        = true
  # An ssh-agent with your SSH private keys should be running
  # Use 'private_key' to set the SSH key otherwise

  file {
    #content       = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.creds-key-github.secret_string))
    source        = "/home/ics/.ssh/id-key-github"                    
    destination   = "/home/ec2-user/.ssh/ssh-key-github"
    permissions   = "0600"
  }

  timeout = "30s"
}
*/

locals {
  pass_rdp = substr(aws_spot_instance_request.test_worker.spot_instance_id, 2, 8)
}

output "ssh_connection" {
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_eip.ip-test-env.public_ip}"
}

#output "endpoint_https" {
#  value = "http://${aws_eip.ip-test-env.public_ip}/index.html"
#}

output "rdp_connection" {
  value = "cmd /k cmdkey /generic:TEMPSRV/${aws_eip.ip-test-env.public_ip} /user:ec2-user /pass:${local.pass_rdp} & mstsc /f /v:${aws_eip.ip-test-env.public_ip}"
}

#output "example" {
#  value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.git-pass.secret_string))["GIT_PASS"]
#  #sensitive = false
#}

#output "example2" {
#  value = local.gitpass
#  #sensitive = false
#}