# Stage 1: Clone and build using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Install git
RUN apt-get update && apt-get install -y git

# Clone your GitHub project
RUN git clone https://github.com/Coding4Deep/java-k8s-project.git

# Set workdir to the project
WORKDIR /java-k8s-project

# Build the project (WAR)
RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat
FROM tomcat:10.1.18-jdk17-temurin

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file from builder
COPY --from=builder /java-k8s-project/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
