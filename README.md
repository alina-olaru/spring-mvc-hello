# spring-mvc-hello

## What this is

This is a fairly simple *Hello World* web application using Java Spring MVC. However, this is more than just your bare-bones *Hello World* web app--it also provides additional infrastructure boiler-plate for things such as logging and dependency management (see **What this gives you**). The purpose of this repo is to provide a boostrapping infrastructure with which to build a new Java Spring web application. This project was created based on [this Spring tutorial](http://static.springsource.org/docs/Spring-MVC-step-by-step/part1.html), but modified as needed.

## What this isn't

This is not a step-by-step tutorial for Java Spring MVC. This is also not a learning guide for Java Spring or any of the other utilies used in this project (there are, however, in-line comments for your edification if you are more of a novice/beginner). For the most part it is assumed you are somewhat comfortably familiar with Java Spring (or web apps in general), dependency management, ant, etc.

## What this gives you

This generic web app project provides support for and/or uses:

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

- Install ant if you haven't already: `sudo apt-get install ant`
- Create the `ANT_HOME` environment variable and point it to where ant was installed (probably /usr/share/ant/)
- Get the ant-contrib-1.0b3.jar file by downloading [this zip file](http://sourceforge.net/projects/ant-contrib/files/ant-contrib/1.0b3/ant-contrib-1.0b3-bin.tar.gz/download), extracting the contents, and copying the ant-contrib-1.0b3.jar file to `$ANT_HOME`/lib/ (create the lib directory if it doesn't exist)
- Download the latest Ivy package [here](http://ant.apache.org/ivy/download.cgi) and extract the contents. Copy the ivy-[version].jar jar file to `$ANT_HOME`/lib/.
- Download Tomcat 8 [here](http://mirror.sdunix.com/apache/tomcat/tomcat-8/v8.0.30/bin/apache-tomcat-8.0.30.tar.gz) and extract into `$WORKSPACE` (or wherever you want, but you'll have to update the `tomcat.home.dir` property in [build.properties](./build.properties) if you don't place it in `$WORKSPACE`)
- Create the `CATALINA_HOME` environment variable and point it to your Tomcat 8 home directory
- Download the Java 8 package [here](downloaded Java 8 from http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
- Extract the contents and move them to /usr/lib/jvm: `sudo mv jdk<version> /usr/lib/jvm/`
- Install the new Java:
  - `sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk<version>/bin/javac 1`
  - `sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk<version>/bin/java 1`
  - `sudo update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/jdk<version>/bin/javaws 1`
  - `sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk<version>/bin/jar 1`
- Make sure JAVA_HOME is set to the new directory under /usr/lib/jvm: `export JAVA_HOME=/usr/lib/jvm/jdk<version>`

## View Rendering

This project comes with Freemarker baked in, but if you'd rather use JSP for views:

- Uncomment the bean defined with `org.springframework.web.servlet.view.InternalResourceViewResolver` in [./web/WEB-INF/app-servlet.xml] (the comment with "JSP")
- Comment out or delete the `org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver` bean and the "freemarkerConfig" bean (in the same file).
- remove the "freemarker" dependency in [./ivy.xml]

## Logging

This project uses [logback](http://logback.qos.ch/) for logging. It is configured in [./web/WEB_INF/classes/logback.xml] and setup with the following:

- **USAGE** messages are written to `$CATALINA_HOME`/logs/app.log with daily and size limit rolling policy
- **DEGUB** messages are turned off by default, but if turned on would be written out to `$CATALINA_HOME`/logs/app.debug.log with the same rolling policy
- **ERROR** message are writen to `$CATALINA_HOME`/logs/app.log and `$CATALINA_HOME`/logs/app.error.log with the same rolling policy
- all messages use the format: \[datetime\]\[log level\]\[tracekey\]\[user\]\[logger\]: \[message\]\[newline\]\[exception (if applicable)\]
(initially *user* will of course be empty since the app is not setup for logging in with users, but is there as a placeholder if and when you implement such a feature)

This project also provides an interceptor \([./src/main/java/com/app/interceptor/RequestLoggingInterceptor.java]\) to log the start and completion of all incoming requests to the app, as well as a filter \([./src/main/java/com/app/filter/RequestLoggingFilter.java]\) which creates the tracekey for log entries. [MDC](http://logback.qos.ch/manual/mdc.html) is used to log information such as tracekeys and users \(see [./src/main/java/com/app/util/RequestLoggingUtil.java]\).

Exceptions are also handled and logged appropriately (even if the exception is thrown during view rendering) via [./src/main/java/com/app/resolver/ExceptionResolver.java] and `<error-page>` definitions in [./web/WEB-INF/web.xml].

## What do I do now?

First, you'll probably want to sanity check this project in your environment to make sure it actually works. First try running `ant ivy-resolve` to get the project dependecies. Then, run `ant tests` to verify the tests build, run, and pass succesfully. Then run `ant deploy-war` and `ant tomcat-start`. http://localhost:8080/app/hello.html should then display the *Hello World* page. Hooray! (or Dang it! It didn't work!--in which case you'll have to troubleshoot as best you can. Start by looking in the tomcat logs (`$CATALINA_HOME`/logs)).

Second, you'll probably want to rename "app" with whatever your project name is. You could do this manually, but this project provides a shell script to do it for you: [./rename_project.sh]--just give it a name as an argument. ("app" is replaced in the appropriate places such as build.properties and the java package names).

Now it's just a matter of taking it from here, assuming you are familiar with Java Spring MVC--creating new Controllers and methods to handle certain urls, and corresponding .ftl (or .jsp) views. Of course, most likely you will need an underlying database with Model objects and a Service layer and what not. Perhaps I will include some instructions on how to add that (probably [http://www.postgresql.org/](PostgreSQL), [http://hibernate.org/](Hibernate), and [http://www.liquibase.org/](liquibase)) here in the future.

Once you are up and running, you can delete the stuff unnecessary to your project (like [./src/main/java/com/app/controller/HelloController.java] and its corresponding test, this README, [./rename_project.sh], etc).

**NOTE:** there is also an ant target, `tomcat-debug-start` to provide debugging through Eclipse. In Eclipse, setup a Debug Configuration (**Run** -> **Debug Configurations...**) pointing to your project, and set the port to 8001 (you can use a different port, but be sure to change the `tomcat.jpda.address` property in [./build.properties] to match). Just start tomcat with `tomcat-debug-start`, run **Debug As**: \[your project\] in Eclipse, set your breakpoints, and debug away.
