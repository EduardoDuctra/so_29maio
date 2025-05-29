# Stage 1: Build
FROM maven:3.8.7-openjdk-17-slim AS build


ENV APP_DIR=/app

WORKDIR $APP_DIR

# Clonar seu projeto do GitHub
RUN git clone https://github.com/EduardoDuctra/so_29maio.git .

# Build do projeto (assumindo Maven)
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

ENTRYPOINT ["java", "-jar", "app.jar", "--logging.file=/logs/app.log"]
