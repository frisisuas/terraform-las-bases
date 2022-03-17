# exercise: vm with keyvault secrets #

Que vamos a desplegar en este ejercicio.

## En el ejercicio 1. ## 
Vamos a desplegar un RG con un storage account y un contenedor de blobs para almacenar el tfstate.

![Creación de un backend para el tfstate del despliegue.](./images/creation_backend.png)

## En el ejercicio 2. ##
Desplegaremos un keyvault dentro de un RG con 2 secretos.

![Creación de un Key Vault y adición de secretos.](./images/kv_and_secrets.png)

## En el ejercicio 3. ##
Desplegaremos una máquina virtual cogiendo los secretos del keyvault. Con ello, conseguiremos que nuestro despliegue contenga claves o texto sensible a posibles filtraciones involuntarias.

![Despliegue de una VM con los secretos desde el KV.](./images/vm_deploy_with_screts_from_kv.png)

