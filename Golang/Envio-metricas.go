package main

import (
	"crypto/tls"
	"bytes"
	"encoding/json"
	"math/rand"
	"fmt"
	"net/http"
	"time"
	"io"
	"log"
)

const host_metricas = "Host metricas"

type Metrica struct {
	IdEjecucion string `json:"id_ejecucion"`
	Fk_Flujo string `json:"fk_flujo"`
	Fk_Metrica string `json:"fk_metrica"`
	Adjetivo1 string `json:"Adjetivo1"`
	Adjetivo2 string `json:"Adjetivo2"`
	Adjetivo3 string `json:"Adjetivo3"`
	Adjetivo4 string `json:"Adjetivo4"`
	AcumuladoMetrica string `json:"AcumuladoMetrica"`
	FechaInicioEjecucion string `json:"FechaInicioEjecucion"`
	FechaFinEjecucion string `json:"FechaFinEjecucion"`
	Fk_Pais string `json:"fk_pais"`
	NotaInterna string `json:"NotaInterna"`
	Timestamp string `json:"Timestamp"`
}

func generateUUID() string {
	b := make([]byte, 16)
	rand.Read(b)
	b[6] = (b[6] & 0x0f) | 0x40 // UUID v4
	b[8] = (b[8] & 0x3f) | 0x80
	return fmt.Sprintf("%x-%x-%x-%x-%x", b[0:4], b[4:6], b[6:8], b[8:10], b[10:])
}

func main() {	
	// Genera el identificador unico asociada a la ejecucion del automatismo
	id_ejecucion := generateUUID()

	// Recoge la fecha de inicio de proceso
	inicio_proceso := time.Now().Format("2006-01-02 15:04:05")


	// .... Proceso del automatismo ...

	// ...
	ejecuciones_metrica := 1


	// Recoge la fecha de fin de proceso
	fin_proceso := time.Now().Format("2006-01-02 15:04:05")

	client := &http.Client{
		Transport: &http.Transport{
        	TLSClientConfig: &tls.Config{InsecureSkipVerify: true}, // ⚠️ Solo en desarrollo
    	},
	}

	fk_flujo_proceso := "12345"
	fk_metrica_proceso := "abcde"
	adjetivo1_proceso := "Ejemplo"
	fk_pais_proceso := "ES"
	notas_proceso := "Ejecucion del proceso a fecha: " + fin_proceso

	metricas := Metrica{ 
		IdEjecucion: id_ejecucion, 
		Fk_Flujo: fk_flujo_proceso, 
		Fk_Metrica: fk_metrica_proceso,
		Adjetivo1: adjetivo1_proceso,
		Adjetivo2: "", 
		Adjetivo3: "",
		Adjetivo4: "",
		AcumuladoMetrica: fmt.Sprintf("%d", ejecuciones_metrica),
		FechaInicioEjecucion: inicio_proceso,
		FechaFinEjecucion: fin_proceso,
		Fk_Pais: fk_pais_proceso,
		NotaInterna: notas_proceso,
		Timestamp: fin_proceso,
	}

	requestBody, _ := json.Marshal(metricas)
	req, _ := http.NewRequest("POST", host_metricas, bytes.NewBuffer(requestBody))

	req.Header.Add("Content-Type", "application/json");
	req.Header.Add("TokenAuth", "Token para el host de metricas");

	resp, err := client.Do(req)

	if err != nil {
    	log.Fatalf("Error haciendo POST: %v", err)
	}
	defer resp.Body.Close()

	// Leer la respuesta
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Fatalf("Error leyendo respuesta: %v", err)
	}

	fmt.Println("Respuesta del servidor:", string(body))
}
