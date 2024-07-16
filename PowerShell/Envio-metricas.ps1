<#
    Author: Emilio Crespo Perán <emilio.crespoperan@telefonica.com>
    Last updated: 16/7/2024

    Script que envia datos de metricas en lenguaje PowerShell
#>


# Genera el identificador unico asociada a la ejecucion del automatismo
$id_ejecucion = New-Guid


# Ejecuta el proceso del automatismo
$inicio_proceso = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# ... Ejecucion del proceso...
$ejecuciones_metrica = 1

# Finaliza proceso
$fin_proceso = Get-Date -Format "yyyy-MM-dd HH:mm:ss"



# Define los datos de metricas asociadas al proceso
$fk_flujo_proceso = "12345"
$fk_metrica_proceso = "abcde"
$adjetivo1_proceso = "Ejemplo"
$fk_pais_proceso = "ES"
$notas_proceso = "Ejecucion del proceso a fecha: $fin_proceso"


# Rellena el modelo de metricas
$metricData = @{
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


# Prepara el envio de metricas
$host_metricas = "https://host_metricas.com"
$token = @{
    TokenAuth = "token-prueba"
}

# Convierte los datos de metricas a formato JSON
$jsonData = $metricData | ConvertTo-Json

  
# Envia las metricas generadas por el automatismo mediante POST
$response = Invoke-RestMethod -Uri $host_metricas -Method Post -Body $jsonData -ContentType 'application/json' -Headers $token
 

# Verificar la respuesta
if ($response.statusCode -eq 201 -and $response.statusMessage -eq "OK") {
    Write-Host "Métrica registrada correctamente."
}
else {
    Write-Host "Error al registrar la métrica. Detalles: $($response | ConvertTo-Json -Depth 5)"
} 
