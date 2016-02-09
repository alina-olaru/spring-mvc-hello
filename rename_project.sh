#!/bin/bash

function usage() {
    echo -e "\n\tusage: rename_project.sh [name]\n"
}

function noArg() {
    echo -e "\nERROR: no project name given"
    usage
    exit
}

#check for command-line arg
if [ $# -ne 1 ]
then
    noArg
elif [ -z $1 ]
then
    noArg
fi

name=$1

sed -i "s/app\./$name./g" ./web/WEB-INF/classes/logback.xml
sed -i "s/<servlet-name>app/<servlet-name>$name/g" ./web/WEB-INF/web.xml
sed -i "s/com\.app/com.$name/g" ./web/WEB-INF/web.xml
sed -i "s/com\.app/com.$name/g" ./web/WEB-INF/app-servlet.xml
sed -i "s/app\.properties/$name.properties/g" ./web/WEB-INF/app-servlet.xml
sed -i "s/=app/=$name/g" ./build.properties
sed -i "s/name=\"app/name=\"$name/g" ./build.xml
grep -rl "com.app" ./src/ | xargs sed -i "s/com\.app/com.foo/g"

git mv ./src/main/java/com/app ./src/main/java/com/$name
git mv ./web/WEB-INF/app-servlet.xml ./web/WEB-INF/$name-servlet.xml
git mv ./conf/app.properties ./conf/$name.properties
