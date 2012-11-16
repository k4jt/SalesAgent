
del /F /S /Q C:\tomcat\webapps\SalesAgent\*
del /F /Q C:\tomcat\webapps\SalesAgent.war
del /F /Q C:\tomcat\webapps\SalesAgent
copy /Y target\SalesAgent.war C:\tomcat\webapps\
C:\tomcat\bin\startup.bat