# 빌드 시점에 사용할 환경 변수 ARG 정의
ARG JWT_SECRET_KEY

# gradle:7.3.1-jdk17 이미지를 기반으로 함
FROM krmp-d2hub-idock.9rum.cc/goorm/gradle:8.7-jdk17

# 작업 디렉토리 설정
WORKDIR /home/gradle/project

# Spring 소스 코드를 이미지에 복사
COPY . .

# 런타임에 사용할 환경 변수 ENV 설정
ENV JWT_SECRET_KEY=$JWT_SECRET_KEY
RUN echo "JWT_SECRET_KEY=${JWT_SECRET_KEY}"

# gradle 빌드 시 proxy 설정을 gradle.properties에 추가
RUN echo "systemProp.http.proxyHost=krmp-proxy.9rum.cc\nsystemProp.http.proxyPort=3128\nsystemProp.https.proxyHost=krmp-proxy.9rum.cc\nsystemProp.https.proxyPort=3128" > /root/.gradle/gradle.properties

# gradlew를 이용한 프로젝트 필드
RUN chmod +x ./gradlew && ./gradlew clean build


# 빌드 결과 jar 파일을 실행
CMD ["java", "-Dhttp.proxyHost=krmp-proxy.9rum.cc", "-Dhttp.proxyPort=3128", "-Dhttps.proxyHost=krmp-proxy.9rum.cc", "-Dhttps.proxyPort=3128", "-Dspring.profiles.active=prod", "-jar", "/home/gradle/project/build/libs/webIde-1.0.jar"]