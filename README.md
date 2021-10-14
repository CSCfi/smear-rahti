# smear-rahti
This project archived because it has replaced by
https://github.com/CSCfi/smear-frontend
and
https://github.com/CSCfi/smear-backend

Old version of the avaa-smear targeted to run in rahti, container.

Undertow project which connect to SMEAR-database. 

## Backgroud

This was test part of removed AVAA-platform modernization AVAA-843.
There is no more any framework like Spring or Speedment.

### Installing

The project has maven pom.xml. It takes only 5s to mvn package.

## Running 

java -jar  target/smear.jar 

## Docker image cretion
mvn clean install
- to skip image creation add -Ddockerfile.skip=true
- i.e mvn clean install -Ddockerfile.skip=true

## License

This project is licensed under the Apache License - see the [LICENSE.md](LICENSE.md
) file for deta
ils

You can get also other licenses.

## Authors

* **Pekka Järveläinen** - *Initial work* - 
* **Shreyas Deshpande** - *Docker support* - 
