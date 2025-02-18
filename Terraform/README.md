Terraform
=========

Este directorio contiene ejemplos de cómo enviar métricas utilizando Terraform.

Descripción
-----------

El envío de métricas para desarrollos basados en Terraform se basa en la utilización de un bloque
de tipo `resource "terraform_data"`, que internamente contiene otro bloque `local-exec` que le
permite ejecutar un script.

Este script, en Bash, se encarga de enviar las métricas a un servidor de métricas, usando variables
de Terraform como entrada.

> [!NOTE]
> El ejemplo provisto en este directorio requiere de **Terraform 1.10 o superior**, ya que hace uso
> del bloque `terraform_data`. Para versiones anteriores, puede utilizarse el bloque
> `null_resource`.  
> Para más información, consultar la
> [documentación oficial](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource).

Integración
-----------

Para integrar el sistema de ingesta de métricas en un módulo de Terraform existente,basta con copiar
el archivo `telemetry.tf`, junto con el script `send_metrics.sh`, en la misma ruta que el resto de
ficheros Terraform (`.tf`, `.tfvars`, etc).

```bash
.\mi-modulo-terraform
    ├── main.tf
    ├── variables.tf 
    ├── parameters.tfvars  # Modificar #
    ├── outputs.tf
    ├── telemetry.tf       # Nuevo #
    └── send-metrics.sh    # Nuevo #
```

Posteriormente, se deberá modificar el archivo `parameters.tfvars` o
[fichero equivalente](https://developer.hashicorp.com/terraform/language/values/variables)
(`*.auto.tfvars`) donde se recojan los valores reales de ejecución[^1], y añadir el contenido
siguiente:

```hcl
telemetry_country = "ES" # Código de país, según ISO de 2 caracteres
telemetry_token = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx" # UUID del Token de Autenticación
telemetry_workflow = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx" # UUID del Flujo
```

Ejecución
---------

El ejemplo está configurado para asegurarse de que el envío de métricas se realiza siempre que se
ejecute el comando `terraform apply`.

Una vez ejecutado, el script `send-metrics.sh` dejará el resultado de la ejecución en un archivo
`.telemetry`.

Información adicional
---------------------

- La modularidad del fichero `telemetry.tf` permite que el envío de métricas pueda ser desactivado
  en cualquier momento, simplemente renombrando el fichero a, por ejemplo, `telemetry.tf.disabled`.
- El bloque `local-exec` permite la ejecución de scripts locales, pudiéndolo adaptar a cualquier
  lenguaje de programación, por ejemplo, script de Python, PowerShell, etc.
- El script `send-metrics.sh` del ejemplo utiliza **la URL del Endpoint de pruebas**, por lo que
  deberá ser adaptado a la URL del servidor de métricas real cuando se libere a producción.

[^1]: En caso de un módulo de Terraform sencillo, donde no se utilicen ficheros de variables, se
      pueden añadir las variables directamente en el fichero `telemetry.tf`, inicializándolas con
      el valor por defecto a utilizar.
