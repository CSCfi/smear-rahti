FROM maven:3.6.2-jdk-11-slim
MAINTAINER Shreyas Deshpande <shreyas.deshpande@csc.fi>
COPY . opt/smear
RUN ls -la /opt/smear/
RUN chmod -R 777 /opt/smear
RUN ls -la /opt/smear/
WORKDIR /opt/smear 
RUN mvn clean install -Ddockerfile.skip=true
RUN chmod 777 /opt/smear/target/smear.jar
EXPOSE 8888:8888
ENTRYPOINT ["java","-jar","target/smear.jar"]