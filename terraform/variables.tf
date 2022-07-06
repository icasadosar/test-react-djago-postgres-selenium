##############################################################
#
# MODIFY
variable "my-public-ip" { default = "[IP_PUBLICA]" } # http://ifconfig.io/ip
variable "GIT_BRANCH"   { default = "[BRANCH]" }
#
##############################################################
#
# CONF GIT REPO APLICACIONES
variable "GIT_SITE" { default = "[SITE]" }
variable "GIT_REPO_FRONT" { default = "[REPO_FRONT]" }
variable "GIT_REPO_BACK" { default = "[REPO_BACK]" }
variable "GIT_AUTH_USER" { default = "[USER_AUTH_GIT]" }
#
# CONF GIT REPO DEVOPS
variable "GIT_DEVOPS_SITE" { default = "[icasadosar]" }
variable "GIT_DEVOPS_REPO" { default = "prueba01" }
variable "GIT_DEVOPS_BRANCH" { default = "[BRANCH]" }
variable "GIT_DEVOPS_AUTH_USER" { default = "[USER_AUTH_GIT]" }
#
#
##############################################################
variable "cidr" { default = "10.0.0.0/16" }
variable "subnet" { default = "10.0.1.0/24"}
variable "aws_region" { default = "eu-west-1" }
variable "ec2_instance" { default = "t3.large" }
variable "ec2_ami" { default = "ami-XXXXXXXX" }
  #ami = "ami-0d71ea30463e0ff8d" # Amazon Linux
  #ami = "ami-033657df95dbf281a" # Amazon Linux Desktop https://aws.amazon.com/marketplace/pp/prodview-5hi2fimh2mjl2
  #ami = "ami-0c454ba4ed5ef1f2d" # AMI Trak Amazon Linux Desktop Test
##############################################################
#