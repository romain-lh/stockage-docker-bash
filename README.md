# stockage-docker-bash

Pour realiser se tp nous allons creer un dossier toi et dans se dossier nous allons creer un fichier csv afin de creer une sauvegarde automatique 

* Nous allons indentifier l'emplacement du repertoire toi dans le owncloud.
Pour se faire nous allons utiliser la commande :

  ```docker inspect (id du conteneur)``` 

* Ensuite nous allons chercher l'onglet "Mounts": 
	* ensuite sources:""
    * il nous suffira d'ajouter /data/"nom de l'utilisateur"/files ce qui nous indiquera l'emplacement de notre repertoire toi 
    * exemple
 ``` 
 "Mounts": [
            {
                "Type": "volume",
                "Name": "f8664c7c6d65501336552d47a2d7d9f6244f0a388c38bb574d2a6f0437949618",
                "Source": "/var/lib/docker/volumes/f8664c7c6d65501336552d47a2d7d9f6244f0a388c38bb574d2a6f0437949618/_data",
```
                
* Ensuite nous allons lancer notre script, pour ce faire nous allons dans un premier temps lui donner des droits 

      ``` chmod 777 sauvegarde script.sh```
    * puis nous allons le lancer avec la commande
      ``` ./ script sauvegarde.sh ```
    * ceci nous permettra de verifier si notre script fonctionne 
 
* pour automatiser ceci nous allons utiliser : 

	```crontab -e ```
    * et nous allons modifier la ligne suivante:
    
    ``` 45 23 * * 1 ~/backup_owncloud/backup_toi.sh ```
    
    * ceci va executer le script tout les jours a 23h45
 
    * nous allons par la suite ajouter un autre ligne sur le crontab -e pour transférer le fichier vers un serveur ftp
 
      ``` 50 23 * * 1 ~/FTP.sh ```
    * Ceci nous permettra de transférer le fichier zip dans notre serveur ftp a 23h50.
    
    

