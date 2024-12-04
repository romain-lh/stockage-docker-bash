# stockage-docker-bash

Pour realiser se tp nous allons creer un dossier toi et dans se dossier nous allons creer un fichier csv afin de creer une sauvegarde automatique 

* Nous allons indentifier l'emplacement du repertoire toi dans le owncloud.
Pour se faire nous allons utiliser la commande :

  ```docker inspect (id du conteneur)``` 

* Ensuite nous allons chercher l'onglet "Mounts": 
	* ensuite sources:""
    * ensuite il nous suffira d'ajouter /data/"nom de l'utilisateur"/files ce qui nous indiquera l'emplacement de notre repertoire toi 
    * exemple
 ``` "Mounts": [
            {
                "Type": "volume",
                "Name": "f8664c7c6d65501336552d47a2d7d9f6244f0a388c38bb574d2a6f0437949618",
                "Source": "/var/lib/docker/volumes/	f8664c7c6d65501336552d47a2d7d9f6244f0a388c38bb574d2a6f0437949618/_data",```
