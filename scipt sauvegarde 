#!/bin/bash
apt install zip
# Chemins et configurations
SOURCE_DIR="/var/lib/docker/volumes/f8664c7c6d65501336552d47a2d7d9f6244f0a388c38bb574d2a6f0437949618/_data/data/romain/files/toi"
BACKUP_DIR="/backup_owncloud"
DATE=$(date +"%d-%m-%Y_%H:%M:%S")
BACKUP_FILE="$BACKUP_DIR/sio2-$DATE.zip"

# Vérifier que le répertoire source existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Erreur : le répertoire source $SOURCE_DIR n'existe pas."
    exit 1
fi


# Compresser le contenu du répertoire source dans un fichier ZIP
zip -r "$BACKUP_FILE" "$SOURCE_DIR" > /dev/null 2>&1

# Vérifier si la compression a réussi
if [ $? -eq 0 ]; then
    echo "Sauvegarde réussie : $BACKUP_FILE"
else
    echo "Erreur lors de la création de la sauvegarde."
    exit 1
fi

