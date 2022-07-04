##############################################################
#
# MODIFY MY IP PUBLIC http://ifcondig.io/ip
variable "my-public-ip" { default = "83.58.218.223" }
#
# MODIFY BRANCH GIT
variable "GIT_BRANCH" { default = "CI" }
#
##############################################################

# No modificar
variable "cidr" { default = "10.0.0.0/16" }
variable "subnet" { default = "10.0.1.0/24"}
variable "ec2_instance" { default = "t3.large" }