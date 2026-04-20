# TP MongoDB Docker — Blog DB

Image Docker MongoDB 6.0 préconfigurée avec une base `blog_db` et un validateur de schéma.

## Image Docker Hub
https://hub.docker.com/r/hibasahbane/sahbanehibamongo

## Lancer le conteneur
```bash
docker run -d --name mongo_container --env-file .env -p 27017:27017 hibasahbane/sahbanehibamongo:1.0.0
```


## Preuves de fonctionnement

### check-status.sh
![check-status](screenshots/check-status.png)

### Insertion invalide rejetée
![insertion invalide](screenshots/insertion_invalide_.png)

### Insertion docker ps
![docker ps](screenshots/docker_ps.png)
