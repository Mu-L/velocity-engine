@echo off

REM -----------------------------------------------------------
REM The targets are the different build scripts.
REM The default "jar" is suggested
REM and does not require any external packages
REM 
REM "compile"           target builds Turbine core classes
REM "clean"          target removes bin directory
REM "jar"           target builds "core" + jar file
REM "javadocs"        target builds the javadocs
REM -----------------------------------------------------------
set TARGET=%1%
REM set TARGET=javadocs
REM set TARGET=compile
REM set TARGET=clean
REM set TARGET=jar

REM -------------------------------------------------------------------
REM Define the paths to each of the packages.
REM -------------------------------------------------------------------
set LIB=lib
set ANT=%LIB%\ant.jar
set ANTXML=%LIB%\xml.jar
set XERCES=%LIB%\xerces-1.1.3.jar
set SERVLET=%LIB%\servlet.jar
set ORO=%LIB%\oro.jar

set LOG=%LIB%\log.jar
set JAVACLASS=%LIB%\JavaClass.jar

set JUNIT=%LIB%\junit-3.2.jar

set XALAN=%LIB%\xalan_1_1_D01.jar
set FOP=%LIB%\fop.jar
set W3C=%LIB%\w3c.jar
set SB=%LIB%\stylebook-1.0-b2.jar

REM --------------------------------------------
REM No need to edit anything past here
REM --------------------------------------------
set BUILDFILE=build-velocity.xml

if "%TARGET%" == "" goto setdist
goto final

:setdist
set TARGET=jar
goto final

:final

REM set JIKES to be non-null (eg set JIKES=Y) to use the jikes compiler - 
REM its a bit faster
REM get it from here... 
REM http://oss.software.ibm.com/developerworks/opensource/jikes/project
set JAVAC=classic
if not "%JIKES%" == "" set JAVAC=jikes

if "%JAVA_HOME%" == "" goto javahomeerror
if exist %JAVA_HOME%\lib\tools.jar set CLASSPATH=%CLASSPATH%;%JAVA_HOME%\lib\tools.jar

echo Now building %TARGET%...

set CP=%CLASSPATH%;%TOOLS%;%ANT%;%ANTXML%;%XERCES%;%XALAN%;%SB%;%LOG%;%FOP%;%LIB%;%W3C%;%JAVACLASS%;%SERVLET%;%JUNIT%;%ORO%

echo Classpath: %CP%
echo JAVA_HOME: %JAVA_HOME%

%JAVA_HOME%\bin\java.exe -classpath "%CP%" -DJAVAC=%JAVAC% org.apache.tools.ant.Main -buildfile %BUILDFILE% %TARGET%

goto end

REM -----------ERROR-------------
:javahomeerror
echo "ERROR: JAVA_HOME not found in your environment."
echo "Please, set the JAVA_HOME variable in your environment to match the"
echo "location of the Java Virtual Machine you want to use."

:end
