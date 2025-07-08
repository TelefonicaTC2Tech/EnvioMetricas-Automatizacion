import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/***************************************************************************
 * @author Emilio Crespo Peran <emilio.crespoperan@telefonica.com>
 * @since 08/07/2025
 *
 * Modelo de datos con patrón Builder que conforma el modelo de métricas
 ***************************************************************************/

public class Metric {

    private final String idEjecucion;
    private final String fkFlujo;
    private final String fkMetrica;
    private final String adjetivo1;
    private final String adjetivo2;
    private final String adjetivo3;
    private final String adjetivo4;
    private final Integer acumuladoMetrica;
    private final Date fechaInicioEjecucion;
    private final Date fechaFinEjecucion;
    private final String fkPais;
    private final String notaInterna;
    private final Date timestamp;

    private Metric(Builder builder) {
        this.idEjecucion = builder.idEjecucion != null ? builder.idEjecucion : UUID.randomUUID().toString();
        this.fkFlujo = builder.fkFlujo;
        this.fkMetrica = builder.fkMetrica != null ? builder.fkMetrica : "";
        this.adjetivo1 = builder.adjetivo1;
        this.adjetivo2 = builder.adjetivo2 != null ? builder.adjetivo2 : "";
        this.adjetivo3 = builder.adjetivo3 != null ? builder.adjetivo3 : "";
        this.adjetivo4 = builder.adjetivo4 != null ? builder.adjetivo4 : "";
        this.acumuladoMetrica = builder.acumuladoMetrica != null ? builder.acumuladoMetrica : 1;
        this.fechaInicioEjecucion = builder.fechaInicioEjecucion;
        this.fechaFinEjecucion = builder.fechaFinEjecucion != null ? builder.fechaFinEjecucion : new Date();
        this.fkPais = builder.fkPais != null ? builder.fkPais : "ES";
        this.notaInterna = builder.notaInterna != null ? builder.notaInterna : "";
        this.timestamp = builder.timestamp != null ? builder.timestamp : new Date();
    }

    public String getIdEjecucion() {
        return this.idEjecucion;
    }

    public String getFkFlujo() {
        return this.fkFlujo;
    }

    public String getFkMetrica() {
        return this.fkMetrica;
    }

    public String getAdjetivo1() {
        return this.adjetivo1;
    }
    
    public String getAdjetivo2() {
        return this.adjetivo2;
    }

    public String getAdjetivo3() {
        return this.adjetivo3;
    }

    public String getAdjetivo4() {
        return this.adjetivo4;
    }

    public Integer getAcumuladoMetrica() {
        return this.acumuladoMetrica;
    }

    public Date getFechaInicioEjecucion() {
        return this.fechaInicioEjecucion;
    }

    public Date getFechaFinEjecucion() {
        return this.fechaFinEjecucion;
    }

    public String getFkPais() {
        return this.fkPais;
    }

    public String getNotaInterna() {
        return this.notaInterna;
    }

    public Date getTimestamp() {
        return this.timestamp;
    }

    public String toJson() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        return String.format(
            "{" +
                "\"id_ejecucion\": \"%s\"," +
                "\"fk_flujo\": \"%s\"," +
                "\"fk_metrica\": \"%s\"," +
                "\"Adjetivo1\": \"%s\"," +
                "\"Adjetivo2\": \"%s\"," +
                "\"Adjetivo3\": \"%s\"," +
                "\"Adjetivo4\": \"%s\"," +
                "\"AcumuladoMetrica\": %d," +
                "\"FechaInicioEjecucion\": \"%s\"," +
                "\"FechaFinEjecucion\": \"%s\"," +
                "\"fk_pais\": \"%s\"," +
                "\"NotaInterna\": \"%s\"," +
                "\"Timestamp\": \"%s\"" +
            "}"
            , this.idEjecucion, this.fkFlujo, this.fkMetrica, this.adjetivo1, this.adjetivo2, this.adjetivo3, this.adjetivo4, this.acumuladoMetrica
            , formatter.format(this.fechaInicioEjecucion), formatter.format(this.fechaFinEjecucion), this.fkPais, this.notaInterna, formatter.format(this.timestamp)
        );
    }


    public static class Builder {

        private final String idEjecucion;
        private final String fkFlujo;
        private String fkMetrica;
        private final String adjetivo1;
        private String adjetivo2;
        private String adjetivo3;
        private String adjetivo4;
        private Integer acumuladoMetrica;
        private final Date fechaInicioEjecucion;
        private Date fechaFinEjecucion;
        private String fkPais;
        private String notaInterna;
        private Date timestamp;

        public Builder(String idEjecucion, String fkFlujo, String adjetivo1, Date fechaInicioEjecucion) {
            if (fkFlujo == null || fkFlujo.isBlank()) {
                throw new IllegalArgumentException("El campo 'fk_flujo' es obligatorio");
            }
            if (adjetivo1 == null || adjetivo1.isBlank()) {
                throw new IllegalArgumentException("El campo 'Adjetivo1' es obligatorio");
            }
            if (fechaInicioEjecucion == null || !fechaInicioEjecucion.before(new Date())) {
                throw new IllegalArgumentException("El campo 'FechaInicioEjecucion' es obligatorio o debe ser anterior al tiempo actual");
            }

            this.idEjecucion = idEjecucion;
            this.fkFlujo = fkFlujo;
            this.adjetivo1 = adjetivo1;
            this.fechaInicioEjecucion = fechaInicioEjecucion;
        }

        public Builder fk_metrica(String fkMetrica) {
            this.fkMetrica = fkMetrica;
            return this;
        }

        public Builder Adjetivo2(String adjetivo2) {
            this.adjetivo2 = adjetivo2;
            return this;
        }

        public Builder Adjetivo3(String adjetivo3) {
            this.adjetivo3 = adjetivo3;
            return this;
        }

        public Builder Adjetivo4(String adjetivo4) {
            this.adjetivo4 = adjetivo4;
            return this;
        }

        public Builder AcumuladoMetrica(Integer acumuladoMetrica) {
            this.acumuladoMetrica = acumuladoMetrica;
            return this;
        }

        public Builder FechaFinEjecucion(Date fechaFinEjecucion) {
            this.fechaFinEjecucion = fechaFinEjecucion;
            return this;
        }

        public Builder fk_pais(String fkPais) {
            this.fkPais = fkPais;
            return this;
        }

        public Builder NotaInterna(String notaInterna) {
            this.notaInterna = notaInterna;
            return this;
        }

        public Builder Timestamp(Date timestamp) {
            this.timestamp = timestamp;
            return this;
        }

        public Metric build() {
            return new Metric(this);
        }

    }

}