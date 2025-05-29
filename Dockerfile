# Stage 1: Build
FROM maven:3.8-openjdk-17 AS build

ENV APP_DIR=/app
WORKDIR $APP_DIR

# Clonar o projeto do GitHub
RUN git clone https://github.com/EduardoDuctra/so_29maio.git .

# Build do projeto (pulando os testes para agilizar)
RUN mvn clean install -DskipTests

# Stage 2: Runtime
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copiar o jar gerado do build
COPY --from=build /app/target/*.jar app.jar

# Criar diretório para logs
RUN mkdir /logs

EXPOSE 8080

VOLUME /logs

# Ajuste na flag para arquivo de log no Spring Boot
ENTRYPOINT ["java", "-jar", "app.jar", "--logging.file.name=/logs/app.log"]
