#!/bin/bash

CONTAINER="mongo_container"
MONGO_USER="root"
MONGO_PASS="root"

echo "=== Vérification MongoDB ==="

# Test 1 : La base blog_db répond et les données sont accessibles
echo "[1/3] Vérification de la base blog_db..."
RESULT=$(docker exec "$CONTAINER" mongosh \
  -u "$MONGO_USER" -p "$MONGO_PASS" \
  --authenticationDatabase admin \
  --quiet \
  blog_db \
  --eval "db.posts.countDocuments()")

if [ $? -ne 0 ] || [ -z "$RESULT" ] || [ "$RESULT" -lt 1 ]; then
  echo " ERREUR : La base blog_db ne répond pas ou est vide."
  exit 1
fi
echo " blog_db accessible — $RESULT document(s) trouvé(s)."

# Test 2 : Vérifier que le service ne tourne PAS en root
echo "[2/3] Vérification de l'utilisateur interne..."
USER=$(docker exec "$CONTAINER" whoami)

if [ "$USER" = "root" ]; then
  echo "ERREUR : MongoDB tourne en tant que root !"
  exit 1
fi
echo "Utilisateur interne : '$USER' (non-root)."

# Test 3 : Vérification du conteneur en cours d'exécution
echo "[3/3] Vérification que le conteneur tourne..."
STATUS=$(docker inspect -f '{{.State.Status}}' "$CONTAINER" 2>/dev/null)

if [ "$STATUS" != "running" ]; then
  echo "ERREUR : Le conteneur n'est pas en cours d'exécution (status: $STATUS)."
  exit 1
fi
echo "Conteneur en cours d'exécution."

echo ""
echo "Tous les tests sont OK !"
exit 0