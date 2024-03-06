**Connect to openshift 

oc login -u [username] -p openshift [url]

oc get projects

**Create key/value secret
name: 

database-name = 

database-user = 

database-password = 

database-root-password = 


**Create mysql application from an image => set env var from secrets 

![image](https://github.com/arijknani/containerized-app/assets/118684147/3ac4b809-5da3-4ea9-8f7e-11f220076f27)


**create config maps 

Name : spring-s2i-ui

db-password = 

db-url = 

db-username = 

**Create spring boot application from a remote Git repository => set env var 

![image](https://github.com/arijknani/containerized-app/assets/118684147/cb6e54cf-8180-4196-9473-10e2ce2e0dd2)

![image](https://github.com/arijknani/containerized-app/assets/118684147/dcc07892-4d12-4e33-b36a-e5a39b3edd80)


![image](https://github.com/arijknani/containerized-app/assets/118684147/00adc4bd-09c4-4678-a582-b7ed725ada5c)


**connect to mysql database 

mysql -u [username] -p

SHOW DATABASES;

use [db-name];

SELECT * FROM [table];




