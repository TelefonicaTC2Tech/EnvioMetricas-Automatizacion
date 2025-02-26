Sub EnvioMetricas()

    Dim http As Object
    Dim url As String
    Dim metricas As String
    
    
    ' Obtiene el tiempo actual
    fecha_inicio_proceso = Format(Now, "yyyy-mm-dd hh:nn:ss")
    
    
	
	
    ' Flujo de procesamiento general
    ' ......
	
	
    
    
    ' Obtiene el tiempo actual
    fecha_fin_proceso = Format(Now, "yyyy-mm-dd hh:nn:ss")
    
    
    ' Configura las metricas del automatismo
    uuid_ejecucion = Int((Now - DateSerial(1970, 1, 1)) * 86400 * 1000 + ((Timer - Int(Timer)) * 1000))
    fk_flujo = "12345"
    fk_metrica = "abdcd"
    adjetivo1 = "Ejemplo"
    adjetivo2 = ""
    adjetivo3 = ""
    adjetivo4 = ""
    acumulado = 1
    pais_ejecucion = "ES"
    nota_interna = "Ejemplo de nota interna"
    
    
    ' Crear el objeto HTTP
    Set http = CreateObject("MSXML2.XMLHTTP")
    
    ' URL del servicio web (Ejemplo)
    url = "http://host_metricas.com"
    token_auth = "token-prueba-ejemplo"
    
    
        
    ' Crear el JSON de metricas
    Dim metricas As String
    metricas = "{ " & vbCrLf & _
              "    ""id_ejecucion"": """ & uuid_ejecucion & """, " & vbCrLf & _
              "    ""fk_flujo"": """ & fk_flujo & """, " & vbCrLf & _
              "    ""fk_metrica"": """ & fk_metrica & """, " & vbCrLf & _
              "    ""Adjetivo1"": """ & adjetivo1 & """, " & vbCrLf & _
              "    ""Adjetivo2"": """ & adjetivo2 & """, " & vbCrLf & _
              "    ""Adjetivo3"": """ & adjetivo3 & """, " & vbCrLf & _
              "    ""Adjetivo4"": """ & adjetivo4 & """, " & vbCrLf & _
              "    ""AcumuladoMetrica"": """ & acumulado & """, " & vbCrLf & _
              "    ""FechaInicioEjecucion"": """ & fecha_inicio_proceso & """, " & vbCrLf & _
              "    ""FechaFinEjecucion"": """ & fecha_fin_proceso & """, " & vbCrLf & _
              "    ""fk_pais"": """ & pais_ejecucion & """, " & vbCrLf & _
              "    ""NotaInterna"": """ & nota_interna & """, " & vbCrLf & _
              "    ""Timestamp"": """ & fecha_fin_proceso & """ " & vbCrLf & _
              "}"
    
    ' Abrir la conexión HTTP con el método POST
    http.Open "POST", url, False
    
    ' Configura los encabezados de la peticion
    http.setRequestHeader "Content-Type", "application/json"
    http.setRequestHeader "TokenAuth", token_auth
    
    
    ' Envia los datos de metricas
    http.Send metricas
    
    ' Verificar la respuesta del servicio
    If http.Status = 201 Then
        ' Obtener el cuerpo de la respuesta
        responseBody = http.responseText
        
        ' Muestra la respuesta
        MsgBox responseBody
    Else
        MsgBox "Error al enviar datos: " & http.Status
    End If


End Sub
