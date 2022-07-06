##############################################################
#
# MODIFY
variable "my-public-ip" { default = "83.58.218.223" } # http://ifconfig.io/ip
variable "GIT_BRANCH"   { default = "CI" }
#
##############################################################
#
# CONF GIT REPO APLICACIONES
variable "GIT_SITE" { default = "traksl" }
variable "GIT_REPO_FRONT" { default = "trakFront" }
variable "GIT_REPO_BACK" { default = "trakBack" }
variable "GIT_AUTH_USER" { default = "icasadosar" }
#
# CONF GIT REPO DEVOPS
variable "GIT_DEVOPS_SITE" { default = "traksl" }
variable "GIT_DEVOPS_REPO" { default = "devops" }
variable "GIT_DEVOPS_BRANCH" { default = "master" }
variable "GIT_DEVOPS_AUTH_USER" { default = "icasadosar" }
#
#
##############################################################
variable "cidr" { default = "10.0.0.0/16" }
variable "subnet" { default = "10.0.1.0/24"}
variable "aws_region" { default = "eu-west-1" }
variable "ec2_instance" { default = "t3.large" }
variable "ec2_ami" { default = "ami-0c454ba4ed5ef1f2d" }
  #ami = "ami-0d71ea30463e0ff8d" # Amazon Linux
  #ami = "ami-033657df95dbf281a" # Amazon Linux Desktop
  #ami = "ami-0c454ba4ed5ef1f2d" # AMI Trak Amazon Linux Desktop Test
##############################################################
#