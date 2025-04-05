# Use an official Maven image to build the app
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and the src directory into the container
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package -Dmaven.test.skip=true

# Use a minimal openjdk image to run the app
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/number-addition-1.0-SNAPSHOT.jar app.jar

# Expose port 8080 (optional)
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
