
********DATA*********
mysql-database: 

mysql-user:

mysql-password:

db-password: 

db-username: 

db-url: jdbc:mysql://mysql-container:3306/


********MYSQL deployment*********

vi mysql-secrets.yaml

----------------
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secrets
type: Opaque
stringData:
  mysql-database: appdb
  mysql-user: arij
  mysql-password: Arijk123*
-----------------

oc apply -f mysql-secrets.yaml

oc get secret mysql-secrets -o yaml

**MYSQL CONTAINER**
oc delete all -l app=mysql-container

oc new-app mysql:latest --name=mysql-container 

oc logs mysql-container-77795d8c69-n8bxk


**ENV**
oc set env --from=secret/mysql-secrets  deployment/mysql-container
**VOLUME**
oc set volume deployment/mysql-container --add --name=mysql-container --type=persistentVolumeClaim --claim-name=mysql --mount-path=/var/lib/mysql

oc get deployment mysql-container -o yaml
oc get pvc 
oc get pv 
oc get pods 
**TEST**
oc logs
oc rsh  
oc exec --stdin --tty mysql-container-684c655b64-2wqkb -- /bin/bash
use appdb;
mysql -u arij -p


********SPRING BOOT deployment*********
**SECRETS**
vi app-secrets.yaml
------------------
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
stringData:
  db-password: Arijk123*
  db-username: arij
------------------
oc apply -f app-secrets.yaml
oc get secret app-secrets -o yaml

**CONFIG MAP**
vi app-configmap.yaml
------------------
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-configmap
data:
  db-url: jdbc:mysql://mysql-container:3306/appdb
------------------
oc apply -f app-configmap.yaml
oc get configmap app-configmap -o yaml


**SPRINGBOOT CONTAINER**
oc delete all -l app=springboot-container
oc new-app https://github.com/arijknani/containerized-app.git#docker-build --name=springboot-container --strategy=docker
**ENV**
oc set env --from=secret/app-secrets  deployment/springboot-container
oc set env --from=configmap/app-configmap  deployment/springboot-container
oc expose service/springboot-container
oc get deployment springboot-container -o yaml
oc logs springboot-container-1-build
oc get routes ==>  http://springboot-container-arij-project.apps.ocp4.smartek.ae






