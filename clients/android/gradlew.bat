@echo off
set DIR=%~dp0
set CLASSPATH=%DIR%\gradle\wrapper\gradle-wrapper.jar

if exist "%CLASSPATH%" (
  java -Xmx64m -cp "%CLASSPATH%" org.gradle.wrapper.GradleWrapperMain %*
  exit /b %errorlevel%
)

where gradle >nul 2>nul
if %errorlevel%==0 (
  gradle %*
  exit /b %errorlevel%
)

echo Gradle wrapper JAR not found and Gradle is not installed. Please install Gradle 8.2.2 or provide the wrapper JAR.
exit /b 1
