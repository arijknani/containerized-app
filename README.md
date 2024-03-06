**Connect to openshift 
oc login -u [username] -p openshift [url]
oc get projects
**create secrets 
oc create secret generic [secret-name] \
--from-literal=database-name=[db-name] \
--from-literal= database-password=[password] \
--from-literal=database-root-password=[rootpassword]  \
--from-literal=database-user=[username]

oc get secret[secret-name] -o yaml 
oc get secret[secret-name] -o jsonpath='{.data.database-password}' | base64 -d

**Create mysql application from an image:
oc new-app mysql:latest --name=[container-name] \
    -e MYSQL_DATABASE=$(oc get secret [secret-name] -o jsonpath='{.data.database-name}' | base64 --decode) \
    -e MYSQL_USER=$(oc get secret[secret-name] -o jsonpath='{.data.database-user}' | base64 -d) \
    -e MYSQL_PASSWORD=$(oc get secret[secret-name] -o jsonpath='{.data.database-password}' | base64 -d) \
    -e MYSQL_ROOT_PASSWORD=$(oc get secret [secret-name] -o jsonpath='{.data.database-root-password}' | base64 -d)

**create config maps 
oc create configmap [CM-name] \
--from-literal=db-password=[password] \
--from-literal=db-url=jdbc:mysql:/[container-name]:3306/[db-name] \
--from-literal=db-username=[username]    
oc get configmaps [CM-name] -o yaml 



**Create spring boot application from a remote Git repository:
oc new-app [git url]#[branch name]  \
--name=[container-name] \
--strategy=docker \
--env=DB_URL=$(oc get configmap  [CM-name] -o jsonpath='{.data.db-url}') \
--env=DB_USERNAME=$(oc get configmap  [CM-name] -o jsonpath='{.data.db-username}') \
--env=DB_PASSWORD=$(oc get configmap  [CM-name] -o jsonpath='{.data.db-password}')

oc expose service/[container-name]
oc status

**connect to mysql database 
oc get pods 
oc rsh <podname>
mysql -u [username] -p
SHOW DATABASES;
use [db-name];
SELECT * FROM <table>;

**Open the url of spring boot container 
oc get route



