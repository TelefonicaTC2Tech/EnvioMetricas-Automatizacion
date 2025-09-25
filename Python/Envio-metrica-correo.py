#####################################################################
#
#   Author: Emilio Crespo Peran <emilio.crespoperan@telefonica.com>
#   Date: 25/09/2025
#
#   Script que envia datos de metricas en lenguaje Python por correo
#
#####################################################################

from datetime import datetime
import uuid
import json
import smtplib
from email.message import EmailMessage


# Genera el identificador unico asociada a la ejecucion del automatismo
id_ejecucion = str(uuid.uuid4())

# INICIO PROCESO DEL AUTOMATISMO
inicio_proceso = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# ...
ejecuciones_metrica = 1

# FIN PROCESO DEL AUTOMATISMO
fin_proceso = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# Define los datos de metricas asociadas al proceso
fk_flujo_proceso = "12345"
fk_metrica_proceso = "abcde"
adjetivo1_proceso = "Ejemplo"
fk_pais_proceso = "ES"
notas_proceso = "Ejecucion del proceso a fecha: {}".format(fin_proceso)

# Rellena el modelo de metricas
lista_metricas = []

metrica = {
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

lista_metricas.append(metrica)




# ... ENVIO DE METRICAS POR CORREO ...

# Configuracion del correo
remitente = "metricas@prueba.es"
destinatario = "destinatario@prueba.es"
asunto = "Envío de métricas"
contenido = "Aquí tienes el fichero de métricas generado"

# Convierte el array de json a bytes
json_bytes = json.dumps(lista_metricas).encode("utf-8")
fichero = "Metricas.json"

# Crear el mensaje
msg = EmailMessage()
msg["From"] = remitente
msg["To"] = destinatario
msg["Subject"] = asunto
msg.set_content(contenido)

# Adjunta los bytes del array de json como fichero adjunto
msg.add_attachment(json_bytes, maintype="application", subtype="octet-stream", filename=fichero)

# Configurar conexión SMTP y enviar correo
smtp_server = "mi-servidor-smtp.com"
smtp_port = 123
user = "mi-usuario"
password = "mi-contraseña"

with smtplib.SMTP(smtp_server, smtp_port) as server:
    server.starttls()
    server.login(user, password)
    server.send_message(msg)

print("Correo enviado!")









