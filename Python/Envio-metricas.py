#####################################################################
#
#   Author: Emilio Crespo Peran <emilio.crespoperan@telefonica.com>
#   Date: 17/07/2024
#
#   Script que envia datos de metricas en lenguaje Python
#
#####################################################################

from datetime import datetime
import requests
import uuid
import json

# Genera el identificador unico asociada a la ejecucion del automatismo
id_ejecucion = str(uuid.uuid4())

# Ejecuta el proceso del automatismo
inicio_proceso = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# ...
ejecuciones_metrica = 1

# Finaliza proceso
fin_proceso = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# Define los datos de metricas asociadas al proceso
fk_flujo_proceso = "12345"
fk_metrica_proceso = "abcde"
adjetivo1_proceso = "Ejemplo"
fk_pais_proceso = "ES"
notas_proceso = "Ejecucion del proceso a fecha: {}".format(fin_proceso)

# Rellena el modelo de metricas
metricData = {
    "id_ejecucion": id_ejecucion,
    "fk_flujo": fk_flujo_proceso,
    "fk_metrica": fk_metrica_proceso,
    "Adjetivo1": adjetivo1_proceso,
    "Adjetivo2": "",
    "Adjetivo3": "",
    "Adjetivo4": "",
    "AcumuladoMetrica": ejecuciones_metrica,
    "FechaInicioEjecucion": inicio_proceso,
    "FechaFinEjecucion": fin_proceso,
    "fk_pais": fk_pais_proceso,
    "NotaInterna": notas_proceso,
    "Timestamp": fin_proceso
}

print(json.dumps(metricData))

# Prepara el envio de metricas
host_metricas = "https://host_metricas.com"
headers = {
    "Content-Type": "application/json",
    "TokenAuth": "token-prueba"
}

# Envia las metricas generadas por el automatismo mediante POST
response = requests.post(host_metricas, headers=headers, json=metricData)

# Verificar la respuesta
print(f"Status Code: {response.status_code}")
print(f"Response Body: {response.text}")

