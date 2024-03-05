1.	Deployment mysql database container
+add => database => mysql => create => start rollout
Username = [username] /password = [password] /db name = [db-name] /database root password = [root-password]

*In secret I add this values :
database-name =>  [db-name] /
databse-user => [username] /
database-password => [password] /
database-root-password => [root-password] /

![image](https://github.com/arijknani/containerized-app/assets/118684147/a3cb339b-4da2-4322-879b-09c841806256)

*commands for mysql CLI
> mysql -u [username] -p
> SHOW DATABASES ;
> 
![image](https://github.com/arijknani/containerized-app/assets/118684147/9dfa8ab2-7c2f-4b57-a21d-9afe764ac25b)

![image](https://github.com/arijknani/containerized-app/assets/118684147/7f55d611-cd81-4713-9351-7825c3c14090)


2.	Deployment spring boot  container from git
   
+add => import from git 
git repo url : https://github.com/arijknani/containerized-app.git
git refreance : my-app-dockerbuild-UI
import strategy : dockerfile 
Docker file path : Dockerfile 
create route = checked 

*in configMap : create configMap => 
name : spring boot 
db-url : jdbc:mysql://<service-name>:3306/<db-name>  
db-password : [password]

![image](https://github.com/arijknani/containerized-app/assets/118684147/c3b3f755-ee7c-475d-8d4d-fb01d14a2dc4)
*commands for mysql CLI 
> mysql -u [username] -p
> SHOW DATABASES ;
> use <db>;
> SHOW tables;
> SELECT * FROM <table>;

