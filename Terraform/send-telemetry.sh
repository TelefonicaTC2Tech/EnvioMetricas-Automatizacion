#!/bin/bash

# Telefonica Cybersecurity & Cloud Tech
#
# Helper utility to send Telemetry data to a remote endpoint.
#
# This script is intended to be run from a `terraform_data` resource
# block, placed within a Terraform module.
#
# After that, this script will use Environment Vars as inputs to
# forward the data to a remote Endpoint.
#

if [[ -z "${TL_WORKFLOW}" ]]; then
    echo "Error: TL_WORKFLOW is not set."
    exit 1
fi

if [[ -z "${TL_TOKEN}" ]]; then
    echo "Error: TL_TOKEN is not set."
    exit 1
fi

if [[ -z "${TL_COUNTRY}" ]]; then
    echo "Error: TL_COUNTRY is not set."
    exit 1
fi

# Defaults. Change Endpoint when released into production.
DEFAULT_EP="https://adm.pre.cloudportal.telefonicatech.com/WS/v2/api/AUTO_flujos_ejecuciones"
METRIC=""
ACUM=1
AD1="Mi-Adjetivo-1"
AD2="Mi-Adjetivo-2"

# Runtime Params
UUID=$(uuidgen)
TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

BODY="{
    \"id_ejecucion\": \"$UUID\",
    \"fk_flujo\": \"$TL_WORKFLOW\",
    \"fk_metrica\": \"$METRIC\",
    \"Adjetivo1\": \"$AD1\",
    \"Adjetivo2\": \"$AD2\",
    \"Adjetivo3\": \"\",
    \"Adjetivo4\": \"\", 
    \"AcumuladoMetrica\": \"$ACUM\",
    \"FechaInicioEjecucion\": \"$TIME\",
    \"FechaFinEjecucion\": \"$TIME\",
    \"fk_pais\": \"$TL_COUNTRY\",
    \"NotaInterna\": \"\",
    \"Timestamp\": \"$TIME\"
}"

curl --request POST --location "$DEFAULT_EP" \
     --header "TokenAuth: $TL_TOKEN" \
     --data "$BODY" --output .telemetry --silent

STATUS=`cat .telemetry | grep -o '"statusCode": [0-9]*' | awk '{print $2}'`
REASON=`cat .telemetry | grep -o '"statusMessage":.*[^,]'`

if [ "$STATUS" = "201" ]; then
    echo "Telemetry Data Sent OK"
else
    echo "Error when sending Telemetry Data. Check '.telemetry':"
    echo $REASON
fi