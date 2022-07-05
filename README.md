## Table of Contents
1. [General Info](#general-info)
2. [Technologies](#technologies)
3. [Requirements](#requeriments)
4. [Installation](#installation)
5. [Execution](#execution)
6. [Collaboration](#collaboration)
7. [FAQs](#faqs)
### General Info
***
Despliegue entorno CI

El entorno esta destinado a ser instaklado y ejecutado en sistemas Linux y derivados (MacOS, WSL)

## Technologies
***
A list of technologies used within the project:
* [Terraform](https://www.terraform.io/): Version 1.2.3
* [Ansible](https://www.ansible.com/): Version 2.9.23
* [AWS Cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## Requeriments

### WSL
*En caso de sistemas Windows es necesario instalar* 
[Instalación Windows Subsystem Linux - WSL](https://docs.microsoft.com/en-us/windows/wsl/install)

### Configuración creadenciales AWS
*** Solicitar Credenciales ***

```
$ aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: 
Default output format [None]: 
```
[Quick Setup](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html)

### Crear SSH KEY

```
$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/youruser/.ssh/id_rsa): [ENTER]
Enter passphrase (empty for no passphrase): [ENTER]
Enter same passphrase again: [ENTER]
Your identification has been saved in id_rsa.
Your public key has been saved in id_rsa.pub.
```

## Installation
***
Para el despligue del entorno solo es necesario instalar en el equipo local Terraform, ya que el resto de software se instala en el proceso de despliegue.

Pero puede ser interesante instalar Ansible para realizar pruebas sobre el equipo local.

### Terraform

[Instalación Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

### Ansible

[Instalación Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible)

## Execution

```
$ git clone https://github.com/icasadosar/prueba01
$ cd ./terraform
```

Modificar la variable *my-public-ip* en el fichero *./variables.tf* por la la ip publica de tu conexión https://ifconfig.io/ip

![image](https://user-images.githubusercontent.com/753352/177284779-b4e2eb63-4793-4aa3-a66b-d8034bcc69fe.png)

Iniciar proyecto e instalación de Plugins

```
$ terraform init
```
Revisar plan de ejecución de Terraform

```
$ terraform plan
```

Aplicación del plan de ejecución, en este momento es donde se crea la infraestructura

```
$ terraform apply
```

Cuando finaliza la aplicación del proyecto, se mostraran las cadenas de conexión:

![image](https://user-images.githubusercontent.com/753352/177284147-16a051a1-72a3-4615-a2f7-663f485196d3.png)

Eliminación del proyecto, se debe de ejecutar cuando se ha finalizado los test para que se elimine la infraestructura

```
$ terraforma destroy
```

## Collaboration
***

## FAQs
***