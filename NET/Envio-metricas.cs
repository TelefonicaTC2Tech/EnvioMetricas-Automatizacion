/***************************************************************************
 * @author Emilio Crespo Peran <emilio.crespoperan@telefonica.com>
 * @since 31/10/2025
 *
 * Modelo de datos que conforma el modelo de métricas para .NET
 ***************************************************************************/

using System;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

class Program
{
    static async Task Main()
    {
        // Ejecuta el proceso del automatismo
        string inicio_proceso = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

        // Genera el identificador único asociado a la ejecución del automatismo
        string id_ejecucion = Guid.NewGuid().ToString();

        /*
            INICIO DE EJECUCIÓN DEL AUTOMATISMO
        */

        // Contabiliza las ejecuciones del proceso (en caso de medirse por métrica)
        int ejecuciones_metrica = 1;

        /*
            FIN EJECUCIÓN DEL AUTOMATISMO
        */

        // Finaliza proceso
        string fin_proceso = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

        // Define los datos de métricas asociadas al proceso
        string fk_flujo_proceso = "12345";
        string fk_metrica_proceso = "abcde";
        string adjetivo1_proceso = "Ejemplo";
        string fk_pais_proceso = "ES";
        string notas_proceso = $"Ejecución del proceso a fecha: {fin_proceso}";

        // Rellena el modelo de datos de métricas
        var metricData = new
        {
            id_ejecucion = id_ejecucion,
            fk_flujo = fk_flujo_proceso,
            fk_metrica = fk_metrica_proceso,
            Adjetivo1 = adjetivo1_proceso,
            Adjetivo2 = "",
            Adjetivo3 = "",
            Adjetivo4 = "",
            AcumuladoMetrica = ejecuciones_metrica,
            FechaInicioEjecucion = inicio_proceso,
            FechaFinEjecucion = fin_proceso,
            fk_pais = fk_pais_proceso,
            NotaInterna = notas_proceso,
            Timestamp = fin_proceso
        };

        string jsonData = JsonSerializer.Serialize(metricData);

        // Envía las métricas generadas por el automatismo mediante POST
        using (var client = new HttpClient())
        {
            // Configura el endpoint
            string host_metricas = "https://host_metricas.com";

            // Configura las headers
            string token = "token-prueba";
            client.DefaultRequestHeaders.Add("TokenAuth", token);

            var content = new StringContent(jsonData, Encoding.UTF8, "application/json");

            try
            {
                HttpResponseMessage response = await client.PostAsync(host_metricas, content);
                string respuesta = await response.Content.ReadAsStringAsync();

                Console.WriteLine("✅ Métricas enviadas correctamente:");
                Console.WriteLine(jsonData);
                Console.WriteLine($"\n📨 Respuesta del servidor:\n{respuesta}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Error al enviar la solicitud: {ex.Message}");
            }
        }
    }
}
