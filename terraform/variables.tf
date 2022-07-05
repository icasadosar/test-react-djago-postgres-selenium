##############################################################
#
# MODIFY MY IP PUBLIC http://ifcondig.io/ip
variable "my-public-ip" { default = "83.58.218.223" }
#
# CONF GIT REPO APLICACIONES
variable "GIT_SITE" { default = "traksl" }
variable "GIT_REPO_FRONT" { default = "trakFront" }
variable "GIT_REPO_BACK" { default = "trakBack" }
variable "GIT_BRANCH" { default = "CI" }
variable "GIT_AUTH_USER" { default = "icasadosar" }
#
# CONF GIT REPO DEVOPS
variable "GIT_DEVOPS_SITE" { default = "icasadosar" }
variable "GIT_DEVOPS_REPO" { default = "prueba01" }
variable "GIT_DEVOPS_BRANCH" { default = "master" }
variable "GIT_DEVOPS_AUTH_USER" { default = "icasadosar" }
#
##############################################################

# No modificar
variable "cidr" { default = "10.0.0.0/16" }
variable "subnet" { default = "10.0.1.0/24"}
variable "ec2_instance" { default = "t3.large" }
variable "ec2_ami" { default = "ami-033657df95dbf281a" }
  #ami                    = "ami-0d71ea30463e0ff8d" # Amazon Linux
  #ami                    = "ami-0f68759fb5f855c36" # Trak Amazon Linux Desktop Test