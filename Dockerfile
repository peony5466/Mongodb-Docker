FROM mongo:6.0

# Créer un utilisateur non-root AVANT toute copie
RUN mkdir -p /data/db && chown -R mongodb:mongodb /data/db

# Copier les fichiers en tant que root (OK à ce stade)
COPY init.js /docker-entrypoint-initdb.d/init.js
COPY check-status.sh /usr/local/bin/check-status.sh
RUN chmod +x /usr/local/bin/check-status.sh

# Utiliser l'utilisateur mongodb
USER mongodb

EXPOSE 27017