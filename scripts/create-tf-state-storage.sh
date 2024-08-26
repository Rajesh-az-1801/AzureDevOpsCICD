#!/usr/bin/env bash
echo $BASH_VERSION

RESOURCE_GROUP_NAME=az400-rg
STORAGE_ACCOUNT_NAME=az400str
CONTAINER_NAME=az-400-tf
LOCATION=westus

if [ "${LOCATION}" == "" ]; then
  LOCATION='westus'
fi

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage account
#   Required: "--allow-blob-public-access false"
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --location $LOCATION --sku Standard_LRS --encryption-services blob --allow-blob-public-access false

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

echo "STORAGE_ACCOUNT_NAME=$STORAGE_ACCOUNT_NAME"
echo "CONTAINER_NAME=$CONTAINER_NAME"
echo "ACCOUNT_KEY=$ACCOUNT_KEY"