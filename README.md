**Connect to openshift 

oc login -u [username] -p openshift [url]

oc get projects

****create secrets 
name: mysql-s2i-cli 

oc create secret generic mysql-s2i-cli \
--from-literal=database-name= \

--from-literal=database-password= \

--from-literal=database-root-password=  \

--from-literal=database-user=

oc get secret mysql-s2i-cli -o yaml 

oc get secret mysql-s2i-cli -o jsonpath='{.data.database-password}' | base64 -d


**Create mysql application from an image => set env var from secrets 

![image](https://github.com/arijknani/containerized-app/assets/118684147/3ac4b809-5da3-4ea9-8f7e-11f220076f27)


**create config maps 

Name : spring-s2i-ui

db-password = 

db-url = 

db-username = 

** Create mysql application from an image:
oc new-app mysql:latest --name=mysql-s2i-cli \
    -e MYSQL_DATABASE=$(oc get secret mysql-s2i-cli -o jsonpath='{.data.database-name}' | base64  -d) \
    
    -e MYSQL_USER=$(oc get secret mysql-s2i-cli -o jsonpath='{.data.database-user}' | base64 -d) \
    
    -e MYSQL_PASSWORD=$(oc get secret mysql-s2i-cli -o jsonpath='{.data.database-password}' | base64 -d) \
    
    -e MYSQL_ROOT_PASSWORD=$(oc get secret mysql-s2i-cli -o jsonpath='{.data.database-root-password}' | base64 -d)
    
**Add volume to mysql 
oc get pvc 
oc set volume deployment/mysql-s2i-cli --add --name=mysql-s2i-cli --type=persistentVolumeClaim --claim-name=mysql --mount-path=/var/lib/mysql-s2i-cli

oc delete all -l app=mysql-s2i-cli

**create config maps 
oc create configmap springboot-s2i-cli \
--from-literal=db-password= \

--from-literal=db-url=jdbc:mysql://mysql-s2i-cli:3306/[db_name] \

--from-literal=db-username=

oc get configmaps springboot-s2i-cli -o yaml

oc patch configmap springboot-s2i-cli  --type merge --patch '{"data": {"db-url": "new_url"}}'

oc delete all -l app=springboot-s2i-cli


**Create spring boot application from a remote Git repository:

oc new-app [git url]#s2i-CLI \

--name=springboot-s2i-cli \

--image-stream=java:openjdk-17-ubi8 \

--strategy=source  \

--as-deployment-config=true \

--env=DB_URL=$(oc get configmap springboot-s2i-cli -o jsonpath='{.data.db-url}') \

--env=DB_USERNAME=$(oc get configmap springboot-s2i-cli -o jsonpath='{.data.db-username}') \

--env=DB_PASSWORD=$(oc get configmap springboot-s2i-cli -o jsonpath='{.data.db-password}') \

--env=APP_PROFILE=prod

[Builder image = openjdk-17-ubi8]

oc logs -f buildconfig/springboot-s2i-cli

oc expose service/springboot-s2i-cli

oc status



**connect to mysql database 

mysql -u [username] -p

SHOW DATABASES;

use [db-name];

SELECT * FROM [table];




