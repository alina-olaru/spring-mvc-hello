#!/bin/bash

# Use this script to rename this project before starting to work on it.
# At the time of forking this repo, this project is simply named "app"
# and has many references to such name, so this script does all of the
# manual work involved in renaming all of those references.

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

echo "Renaming log files in logback.xml..."
sed -i "s/app\./$name./g" ./web/WEB-INF/classes/logback.xml
sleep 0.25

echo "Updating references in web.xml..."
sed -i "s/<servlet-name>app/<servlet-name>$name/g" ./web/WEB-INF/web.xml
sed -i "s/com\.app/com.$name/g" ./web/WEB-INF/web.xml
sleep 0.25

echo "Updating references in app-servlet.xml..."
sed -i "s/com\.app/com.$name/g" ./web/WEB-INF/app-servlet.xml
sed -i "s/app\.properties/$name.properties/g" ./web/WEB-INF/app-servlet.xml
sleep 0.25

echo "Updating properties in build.properties..."
sed -i "s/=app/=$name/g" ./build.properties
sleep 0.25

echo "Updating name in build.xml..."
sed -i "s/name=\"app/name=\"$name/g" ./build.xml
sleep 0.25

echo "Updating package names and import statements in java files..."
grep -rl "com.app" ./src/ | xargs sed -i "s/com\.app/com.foo/g"
sleep 0.25

echo "Renaming all package directory paths for java files..."
git mv ./src/main/java/com/app ./src/main/java/com/$name
sleep 0.25

echo "Renaming app-servlet.xml..."
git mv ./web/WEB-INF/app-servlet.xml ./web/WEB-INF/$name-servlet.xml
sleep 0.25

echo "Renaming app.properties..."
git mv ./conf/app.properties ./conf/$name.properties
sleep 0.25

echo -e "\nDONE. Don't forget to commit these changes before doing anything else.\n"
