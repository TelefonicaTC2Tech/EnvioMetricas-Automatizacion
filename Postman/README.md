# Integración de métricas en Postman

Esta colección contiene una petición de envío de métricas, cuya finalidad es la configuración y envío de métricas de los automatismos.

Tiene la particularidad en la que si se ejecutan varias peticiones de la colección y la última es para enviar métricas, es capaz de recoger el tiempo de inicio y de fin para obtener la duración total del procesamiento del automatismo.

Esta característica es posible que no se encuentre en colecciones de Postman de peticionarios, por lo que para poder hacer uso de esta funcionalidad se necesita copiar el siguiente código en la zona de "Scripts" de la colección, concretamente en la pestaña "Pre-request":

``` javascript
// Si no existe el tiempo inicial, lo setea
if (!pm.environment.get("fecha_inicio")) {
    let localDate = new Date();
    let timestamp = localDate.getFullYear() + '-' + 
                    ('0' + (localDate.getMonth() + 1)).slice(-2) + '-' + 
                    ('0' + localDate.getDate()).slice(-2) + ' ' + 
                    ('0' + localDate.getHours()).slice(-2) + ':' + 
                    ('0' + localDate.getMinutes()).slice(-2) + ':' + 
                    ('0' + localDate.getSeconds()).slice(-2);
    pm.environment.set("fecha_inicio", timestamp);
}

 ```

<img src="https://content.pstmn.io/2b047a2d-d8f0-43cc-9193-852a1722f8c7/aW1hZ2UucG5n" width="746" height="304">

El código anterior recoge el tiempo de inicio antes de lanzar la primera petición y las sucesivas peticiones no reemplazarán el valor al realizar una comprobación.

El siguiente paso es copiar la petición de "Send Metrics", donde está completamente configurado el envío de métricas a falta de agregar los datos asignados para el automatismo y que se explica en la siguiente parte.

## Uso de la colección

#### **Paso 1: Configura los datos de métricas**

El equipo del plan de automatización te proporcionará los datos de configuración de métricas correspondientes a tu automatismo, por lo que se te proporcionarán los siguientes datos obligatorios y puede que algunos datos de los campos opcionales dependiendo del automatismo:

- fk_flujo (obligatorio)
    
- fk_metrica (opcional)
    
- Adjetivo1 (obligatorio)
    
- Adjetivo2 (opcional)
    
- Adjetivo3 (opcional)
    
- Adjetivo4 (opcional)
    
- AcumuladoMetrica (especial): Este valor puede que se te indique que sea fijo o que necesites calcularlo, por lo que deberás seguir las intrucciones oportunas del equipo de métricas
    

Estos datos de configuración los puedes indicar como variables en tu colección de Postman o indicarlos directamente en el body de la petición de envío de métricas.

Ten en cuenta que el body de la petición está prácticamente relleno y utilizando variables, por lo que estas no deberán modificarse para que el envío de métricas sea el correcto:

- id_ejecucion
    
- FechaInicioEjecucion
    
- FechaFinEjecucion
    
- Timestamp
    

<img src="https://content.pstmn.io/535ddfb2-0d1d-4ad6-bfda-2ff316b1eef9/aW1hZ2UucG5n" alt="
<br>
<br>" width="658" height="463">

#### **Paso 2: Configura el envío de métricas**

Además de la configuración de métricas, el equipo del plan de automatización te proporcionará los datos del host al que necesitas enviar los datos de métricas.

Esta configuración deberás indicarla en las variables de tu colección, siendo las siguientes variables:

- host_metrics
    
- token_metrics
    

Recuerda, una vez que se validen las métricas en el entorno de PRE deberás modificar el envío de métricas hacia el entorno de PRO, por lo que recomendamos que estos datos se configuren como variables en la colección.

<img src="https://content.pstmn.io/1737f68c-0ea2-4a2d-bc41-c48a1e6ff4a2/aW1hZ2UucG5n" width="839" height="244">

## Repositorio de integración de métricas

Esta colección de Postman para el envío de métricas forma parte de un repositorio de integración de métricas que se encuentra en [https://github.com/TelefonicaTC2Tech/EnvioMetricas-Automatizacion](https://github.com/TelefonicaTC2Tech/EnvioMetricas-Automatizacion)