del "D:\Program Files\apache-tomcat\webapps\ROOT.war"
call mvnn.bat
cd target 
ren SalesAgent.war ROOT.war
copy ROOT.war "D:\Program Files\apache-tomcat\webapps\ROOT.war"

