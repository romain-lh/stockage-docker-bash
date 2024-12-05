#!/bin/bash

# Chemins et configurations
SOURCE_DIR="/var/lib/docker/volumes/f8664c7c6d65501336552d47a2d7d9f6244f0a388c38bb574d2a6f0437949618/_data/data/romain/files/toi "
BACKUP_DIR="/backup_owncloud"
DATE=$(date +"%d-%m-%Y_%H:%M:%S")
BACKUP_FILE="$BACKUP_DIR/sio2-$DATE.zip"
LOG_FILE="/var/log/backup_toi.log"
FTP_SERVER="192.168.20.187"
FTP_USER="root"
FTP_PASS="sio2425"
FTP_DIR="archives_toip"

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]; then
    echo "Veuillez exécuter ce script en tant que superutilisateur (sudo)."
    exit 1
fi

# Création du fichier de log
mkdir -p "$(dirname "$LOG_FILE")"
echo "=== Début de la sauvegarde : $(date) ===" >> "$LOG_FILE"

# Vérifier que le répertoire source existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Erreur : le répertoire source $SOURCE_DIR n'existe pas." | tee -a "$LOG_FILE"
    exit 1
fi

# Créer le répertoire de sauvegarde s'il n'existe pas
mkdir -p "$BACKUP_DIR"
if [ $? -ne 0 ]; then
    echo "Erreur : impossible de créer le répertoire de sauvegarde $BACKUP_DIR." | tee -a "$LOG_FILE"
    exit 1
fi

# Compresser le contenu du répertoire source dans un fichier ZIP
zip -r "$BACKUP_FILE" "$SOURCE_DIR" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Sauvegarde réussie : $BACKUP_FILE" | tee -a "$LOG_FILE"
else
    echo "Erreur : échec de la compression avec zip." | tee -a "$LOG_FILE"
    exit 1
fi

# Transfert FTP
echo "Début du transfert FTP vers le serveur $FTP_SERVER dans le répertoire $FTP_DIR" | tee -a "$LOG_FILE"

# Utilisation de l'outil lftp pour transférer le fichier via FTP
lftp -f "
open ftp://$FTP_USER:$FTP_PASS@$FTP_SERVER
lcd $BACKUP_DIR
cd $FTP_DIR
put $(basename $BACKUP_FILE)
bye
"

# Vérification de l'envoi
if [ $? -eq 0 ]; then
    echo "Transfert réussi : $(basename $BACKUP_FILE) vers $FTP_SERVER/$FTP_DIR" | tee -a "$LOG_FILE"
else
    echo "Erreur lors du transfert FTP." | tee -a "$LOG_FILE"
    exit 1
fi

# Nettoyage des fichiers temporaires
echo "Nettoyage des fichiers temporaires..." | tee -a "$LOG_FILE"
rm -rf "$TEMP_DIR"

# Fin du script
echo "=== Fin de la sauvegarde : $(date) ===" >> "$LOG_FILE"
