<#
    Author: Emilio Crespo Perán <emilio.crespoperan@telefonica.com>
    Last updated: 26/09/2025

    Script que envia datos de metricas en lenguaje PowerShell por correo
#>

# Genera el identificador unico asociada a la ejecucion del automatismo
$id_ejecucion = New-Guid

# INICIO PROCESO DEL AUTOMATISMO
$inicio_proceso = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# ...
$ejecuciones_metrica = 1

# FIN PROCESO DEL AUTOMATISMO
$fin_proceso = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Define los datos de metricas asociadas al proceso
$fk_flujo_proceso = "12345"
$fk_metrica_proceso = "abcde"
$adjetivo1_proceso = "Ejemplo"
$fk_pais_proceso = "ES"
$notas_proceso = "Ejecucion del proceso a fecha: $fin_proceso"


# Rellena el modelo de metricas
$lista_metricas = @(
    [PSCustomObject]@{
        "id_ejecucion" = $id_ejecucion
        "fk_flujo" = $fk_flujo_proceso
        "fk_metrica" = $fk_metrica_proceso
        "Adjetivo1" = $adjetivo1_proceso
        "Adjetivo2" = ""
        "Adjetivo3" = ""
        "Adjetivo4" = ""
        "AcumuladoMetrica" = $ejecuciones_metrica
        "FechaInicioEjecucion" = $inicio_proceso
        "FechaFinEjecucion" = $fin_proceso
        "fk_pais" = $fk_pais_proceso
        "NotaInterna" = $notas_proceso
        "Timestamp" = $fin_proceso
    }
)



# ... ENVIO DE METRICAS POR CORREO ...

# Importante: El envio de metricas por correo siempre debe enviarse como array de objetos JSON
# Convierte el array de JSON en bytes para ser enviados como fichero
$jsonContent = $lista_metricas | ConvertTo-Json -Depth 10

# Si hay un elemento ConvertTo-Json elimina el array por defecto, necesita forzar a que sea un array
if ($lista_metricas.Count -eq 1) {
    $jsonContent = "[" + ($lista_metricas | ConvertTo-Json -Depth 10 -Compress) + "]"
} else {
    $jsonContent = $lista_metricas | ConvertTo-Json -Depth 10
}

$utf8Encoding = New-Object System.Text.UTF8Encoding($false)
$jsonBytes = $utf8Encoding.GetBytes($jsonContent)
$jsonStream = New-Object System.IO.MemoryStream
$jsonStream.Write($jsonBytes, 0, $jsonBytes.Length)
$jsonStream.Position = 0 

# Configuracion del correo
$remitente = "metricas@prueba.es"
$destinatario = "destinatario@prueba.es"
$asunto = "Envío de métricas"
$contenido = "Aquí tienes el fichero de métricas generado"
$nombreAdjunto = "Metricas.json"
$adjunto = New-Object System.Net.Mail.Attachment($jsonStream, $nombreAdjunto, "application/json")

$mail = New-Object System.Net.Mail.MailMessage
$mail.From = $remitente
$mail.To.Add($destinatario)
$mail.Subject = $asunto
$mail.Body = $contenido
$mail.Attachments.Add($adjunto)


# Configuracion de conexión SMTP
$smtpServer = "mi-servidor-smtp.com"
$smtpPort = 123
$user = "mi-usuario"
$password = "mi-contraseña"

$smtp = New-Object System.Net.Mail.SmtpClient($smtpServer, $smtpPort)
$smtp.EnableSsl = $true
$smtp.Credentials = New-Object System.Net.NetworkCredential($user, $password)

# Envia el correo
try {
    $smtp.Send($mail)
    Write-Host "Correo enviado!"
}
catch {
    Write-Host "ERROR al enviar el correo:`n$($_.Exception.Message)"
    if ($_.Exception.InnerException) {
        Write-Host "Detalles internos:`n$($_.Exception.InnerException.Message)"
    }
}


# Limpia los recursos
$adjunto.Dispose()
$jsonStream.Dispose()
$mail.Dispose()

