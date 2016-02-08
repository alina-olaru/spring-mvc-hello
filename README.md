# spring-mvc-hello

This repo provides a Hello World web application using Java Spring. The purpose of this repo is to provide a boostrapping infrastructure with which to build a new Java Spring web application. This project was created based on [this Spring tutorial](http://static.springsource.org/docs/Spring-MVC-step-by-step/part1.html), but modified as needed.

## What this gives you

This fairly simple (but not bare-bones) app provides support for and/or uses:

- Java 8 and [Tomcat 8](https://tomcat.apache.org/tomcat-8.0-doc/introduction.html)
- [ant](http://ant.apache.org/) with targets to build, test, deploy, clean, and start/stop Tomcat
- [Freemarker](http://freemarker.incubator.apache.org/) or JSP for view rendering (see **View Rendering** for more details)
- [logback](http://logback.qos.ch/) for logging (see **Logging** section for more details)
- [ivy](http://ant.apache.org/ivy/) for dependency management

## Prerequisites

You will need the following in order to get things working (see **Environment Setup** for anything you don't have):

- Java 8 and Tomcat 8 (although this may work with Java 6/7 and/or Tomcat 6/7--this was tested using 8, however)
- ant
- an ant-contrib-* jar in your ant's lib dir
- an ivy-* jar in your ant's lib dir
- a `CATALINA_HOME` environment variable (pointing to your Tomcat home directory)
- an `ANT_HOME` environment variable (pointing to your Ant home directory--usually it's something like /usr/share/ant/)
- a `WORKSPACE` environment variable (pointing to the directory where your project lives--if you are using Eclipse for your project, then it would be your Eclipse workspace directory)
- a `JAVA_HOME` environment variable (pointing to the directory where your JDK resides)

## Environment Setup

1. Install ant if you haven't already: `sudo apt-get install ant`
2. Create the `ANT_HOME` environment variable and point it to where ant was installed (probably /usr/share/ant/)
3. Get the ant-contrib-1.0b3.jar file by downloading [this zip file](http://sourceforge.net/projects/ant-contrib/files/ant-contrib/1.0b3/ant-contrib-1.0b3-bin.tar.gz/download), extracting the contents, and copying the ant-contrib-1.0b3.jar file to `$ANT_HOME`/lib/ (create the lib directory if it doesn't exist)
4. Download the latest Ivy package [here](http://ant.apache.org/ivy/download.cgi) and extract the contents. Copy the ivy-[version].jar jar file to `$ANT_HOME`/lib/.
5. Download Tomcat 8 [here](http://mirror.sdunix.com/apache/tomcat/tomcat-8/v8.0.30/bin/apache-tomcat-8.0.30.tar.gz) and extract into `$WORKSPACE` (or wherever you want, but you'll have to update the `tomcat.home.dir` property in [build.properties](./build.properties) if you don't place it in `$WORKSPACE`)
6. Create the `CATALINA_HOME` environment variable and point it to your Tomcat 8 home directory
7. Download the Java 8 package [here](downloaded Java 8 from http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
8. Extract the contents and move them to /usr/lib/jvm: `sudo mv jdk<version> /usr/lib/jvm/`
9. Install the new Java:
  * `sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk<version>/bin/javac 1`
  * `sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk<version>/bin/java 1`
  * `sudo update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/jdk<version>/bin/javaws 1`
  * `sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk<version>/bin/jar 1`
10. Make sure JAVA_HOME is set to the new directory under /usr/lib/jvm: `export JAVA_HOME=/usr/lib/jvm/jdk<version>`

## View Rendering

## Logging

## What do I do now?
