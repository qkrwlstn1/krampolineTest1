FROM khv9786/als_ide_jdk
WORKDIR /app
COPY ./data /app
EXPOSE 8080
CMD ["java", "-jar", "your-application.jar"]

# Dockerfile for Database Service
FROM mysql:latest
COPY ./db/mysql/config/*.cnf /etc/mysql/conf.d/
COPY ./db/mysql/init/*.sql /docker-entrypoint-initdb.d/
ENV MYSQL_ROOT_PASSWORD=!db1234
ENV MYSQL_DATABASE=als_ide_db
ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=!als1234
ENV TZ=Asia/Seoul
EXPOSE 3306