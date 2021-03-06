### General Info
***
Despliegue entorno CI

El entorno esta destinado a ser instaklado y ejecutado en sistemas Linux y derivados (MacOS, WSL)

## Technologies
***
A list of technologies used within the project:
* [Terraform](https://www.terraform.io/): Version 1.2.3
* [Ansible](https://www.ansible.com/): Version 2.9.23
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

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
Ref: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html

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

- Modificar la variable *my-public-ip* y *GIT_BRANCH* en el fichero *./variables.tf* 

*Nota: para obtener la ip publica: https://ifconfig.io/ip

![image](https://user-images.githubusercontent.com/753352/177373517-5d011551-2656-4fd8-a570-65be97e15822.png)

- Iniciar proyecto e instalación de Plugins

```
$ terraform init
```
- Revisar plan de ejecución

```
$ terraform plan
```

- Aplicación del plan de ejecución, en este momento es donde se crea la infraestructura

```
$ terraform apply
```

- Cuando finaliza la aplicación del proyecto, se mostraran las cadenas de conexión:

![image](https://user-images.githubusercontent.com/753352/177371449-4729b63a-6c4b-412d-aa61-06b6cce48ff7.png)

- El entorno queda totalmente desplegado y preparado para realizar los test cuando en el Desktop del usuario se crea el fichero YEARMONTHDAY_HOURMINSEC-init.log (apox 3.5 min)

![image](https://user-images.githubusercontent.com/753352/177376769-ac036719-c658-4886-8b2f-67c7c9fd20aa.png)

- Ejecución Test

```
$ cd /var/trak/back
$ python3 manage.py test --noinput --failfast --nomigrations -v 2 -k [NOMBRE_TEST]
```

- Eliminación del proyecto, se debe de ejecutar cuando se ha finalizado los test para que se elimine la infraestructura

```
$ terraforma destroy
```

## Collaboration
***

## FAQs
***
