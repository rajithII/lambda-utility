#!/bin/sh
utility_build () {
cd utility
source /etc/profile.d/maven.sh
mvn package
mvn install:install-file -Dfile=target/utility-1.0.0.jar -DgroupId=com.cct -DartifactId=utility -Dversion=1.0.0 -Dpackaging=jar
echo "Utility build completed"
cd ..
}
utility_build

lambda_build () {
    cd $1
    cp /utility/target/utility-1.0.0.jar .
    source /etc/profile.d/maven.sh
    mvn package -DskipTests=true
    echo "$1 buid with utility completed"
    cd ..
}

for name in `cat lambdalist.txt`
do 
   echo " Calling Lambda Function"
   lambda_build $name 
done


