/*********************************************************************

   Author: Emilio Crespo Peran <emilio.crespoperan@telefonica.com>
   Date: 12/06/2025

   Script que envia datos de metricas en JavaScript para Google Sheets - Apps Script

*********************************************************************/

// Genera el identificador unico asociada a la ejecucion del automatismo
var id_ejecucion = "10000000-1000-4000-8000-100000000000".replace(/[018]/g, c => (+c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> +c / 4).toString(16));

// Recoge la fecha de inicio de proceso
var fecha_actual = new Date();
var inicio_proceso = fecha_actual.getFullYear() + "-" + ("0"+(fecha_actual.getMonth()+1)).slice(-2)+ "-" + ("0" + fecha_actual.getDate()).slice(-2) + " " + ("0" + fecha_actual.getHours()).slice(-2) + ":" + ("0" + fecha_actual.getMinutes()).slice(-2) + ":" + ("0" + fecha_actual.getSeconds()).slice(-2);


// .... Proceso del automatismo ...

// ...
var ejecuciones_metrica = 1


// Recoge la fecha de fin de proceso
fecha_actual = new Date();
var fin_proceso = fecha_actual.getFullYear() + "-" + ("0"+(fecha_actual.getMonth()+1)).slice(-2)+ "-" + ("0" + fecha_actual.getDate()).slice(-2) + " " + ("0" + fecha_actual.getHours()).slice(-2) + ":" + ("0" + fecha_actual.getMinutes()).slice(-2) + ":" + ("0" + fecha_actual.getSeconds()).slice(-2);


// Define los datos de metrica del proceso
var fk_flujo_proceso = "12345"
var fk_metrica_proceso = "abcde"
var adjetivo1_proceso = "Ejemplo"
var fk_pais_proceso = "ES"
var notas_proceso = "Ejecucion del proceso a fecha: " + fin_proceso

const metrics = JSON.stringify({
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
});


// Crea la configuracion del servidor de métricas
const options = {
	'method': 'post',
	'headers': {'Content-Type': 'application/json', 'TokenAuth': 'Token para el host de metricas'},
	'payload': metrics
};

// Envia las métricas
const response = UrlFetchApp.fetch('Host metricas', options);

// Comprueba las respuestas
if (response.getResponseCode() === 200) {
	console.log('Respuesta de metricas:', JSON.parse(response.getContentText()));
}
else {
	console.error('Error:', response.getResponseCode(), response.getContentText());
}
