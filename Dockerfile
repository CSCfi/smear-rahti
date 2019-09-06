FROM openjdk
MAINTAINER Shreyas Deshpande <shreyas.deshpande@csc.fi>
ADD target/smear.jar smear.jar
RUN chmod 777 smear.jar
EXPOSE 8888:8888
ENTRYPOINT ["java","-jar","smear.jar"]
