#!/bin/sh
utility_build () {
cd utility
source /etc/profile.d/maven.sh
mvn package -DskipTests=true
mvn install:install-file -Dfile=target/utility-1.0.0.jar -DgroupId=com.cct -DartifactId=utility -Dversion=1.0.0 -Dpackaging=jar
echo "Utility build completed"
echo "============================================================================"
cd ..
}
utility_build

lambda_build () {
    echo "repo_name is: $1"
    echo "lambda_name is: $2"
    cd $1
    cp ../utility/target/utility-1.0.0.jar .
    source /etc/profile.d/maven.sh
    mvn package -DskipTests=true
    echo "$2 build with utility completed"
    echo "========================================================================"
    cd ..
}

for line in `cat lambdalist.txt`
do       
        repo_name=$(echo "$line" | cut -d':' -f1)
        lambda_name=$(echo "$line" | cut -d':' -f2)
        echo "========================================================================="
        echo " Calling $lambda_name"
        echo "========================================================================="
        lambda_build $repo_name $lambda_name
done


