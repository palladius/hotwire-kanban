#!/bin/bash

. .env

set -euo pipefail

# log error: DEFAULT 2025-05-25T13:39:46.428977Z raise ArgumentError, "Missing `secret_key_base` for '#{Rails.env}' environment, set this string with `bin/rails credentials:edit`"
gcloud config set project $PROJECT_ID

# Adding "manhouse" to the service name for clarity, to make sure it doesn't conflict with service from CloudBuild.
gcloud run deploy ${SERVICE_NAME}-manhouse \
        --region $REGION \
        --image $REGION-docker.pkg.dev/$PROJECT_ID/cloud-run-source-deploy/$SERVICE_NAME \
        --add-cloudsql-instances "$PROJECT_ID:$REGION:$INSTANCE_NAME" \
        --allow-unauthenticated
