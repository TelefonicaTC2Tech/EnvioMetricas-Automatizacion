import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.UUID;

/***************************************************************************
 * @author Emilio Crespo Peran <emilio.crespoperan@telefonica.com>
 * @since 08/07/2025
 *
 * Clase de ejemplo que envía datos de métricas en lenguaje Java
 ***************************************************************************/

public class EnvioMetricas {

    private final String host = "";
    private final String token = "";

    public static void main(String[] args) {
        new EnvioMetricas().process();
    }

    public void process() {
        String idEjecucionProceso = UUID.randomUUID().toString();
        
        Date inicioProceso = new Date();

        // ... Inicio proceso ...
        
        Integer ejecucionesMetricaProceso = 3;

        // ... Fin proceso ...

        Date finProceso = new Date();

        String IdFlujoProceso = "12345";
        String IdMetricaProceso = "abcde";
        String Adjetivo1Proceso = "Ejemplo";
        String IdPaisProceso = "ES";
        String NotasProceso = String.format("Ejecucion del proceso a fecha: %s", finProceso);

        // Seteo de metrica
        Metric metrica = new Metric.Builder(idEjecucionProceso, IdFlujoProceso, Adjetivo1Proceso, inicioProceso)
            .fk_metrica(IdMetricaProceso)
            .AcumuladoMetrica(ejecucionesMetricaProceso)
            .FechaFinEjecucion(finProceso)
            .fk_pais(IdPaisProceso)
            .NotaInterna(NotasProceso)
            .Timestamp(finProceso)
            .build();

        // Envio de metrica
        enviar(metrica);
    }

    public void enviar(Metric metrica) {
        try {
            URL url = new URL(this.host);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // Prepara el envio de metricas
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("TokenAuth", token);
            conn.setDoOutput(true);
            
            // Enviar JSON
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = metrica.toJson().getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // Imprime el codigo de respuesta
            int responseCode = conn.getResponseCode();
            System.out.println("Status code: " + responseCode);

            conn.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}