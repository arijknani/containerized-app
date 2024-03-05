1.	Deployment mysql database container
+add => database => mysql => create => start rollout
Username = arij /password = pass /db name = sampledb /database root password = root

*In secret I add this values :
database-name => sampledb /
databse-user => arij /
database-password => pass /
database-root-password => root /

![image](https://github.com/arijknani/containerized-app/assets/118684147/a3cb339b-4da2-4322-879b-09c841806256)

*commands for mysql CLI
> mysql -u arij -p
> SHOW DATABASES ;
> 
![image](https://github.com/arijknani/containerized-app/assets/118684147/9dfa8ab2-7c2f-4b57-a21d-9afe764ac25b)

![image](https://github.com/arijknani/containerized-app/assets/118684147/637a6459-c407-493a-84ab-66ce2478c17c)

2.	Deployment spring boot  container from git
   
+add => import from git 
git repo url : https://github.com/arijknani/containerized-app.git
git refreance : my-app-dockerbuild-UI
import strategy : dockerfile 
Docker file path : Dockerfile 
create route = checked 

*in configMap : create configMap => 
name : spring boot 
db-url : jdbc:mysql://mysql:3306/sampledb  == jdbc:mysql://<service-name>:3306/sampledb
db-password : pass

![image](https://github.com/arijknani/containerized-app/assets/118684147/c3b3f755-ee7c-475d-8d4d-fb01d14a2dc4)
*commands for mysql CLI 
> mysql -u arij -p
> SHOW DATABASES ;
> use sampledb;
> SHOW tables;
> 	SELECT * FROM user;

