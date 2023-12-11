# Première étape : construction de l'application avec Maven
FROM maven:3.6.3-openjdk-11 AS builder

WORKDIR /app

# Copier les fichiers POM et source
COPY pom.xml .
COPY src ./src

# Construire le projet et copier le fichier JAR dans le répertoire /app/target
RUN mvn clean package -DskipTests

# Deuxième étape : exécuter l'application avec Java
FROM adoptopenjdk:11-jre-hotspot
# Copier le fichier JAR construit à partir de l'étape précédente
COPY --from=builder /app/target/api-gateway.jar ./app.jar

# Exposer le port sur lequel l'application s'exécute
EXPOSE 8080

# Commande d'exécution de l'application
ENTRYPOINT ["java", "-jar", "app.jar"]