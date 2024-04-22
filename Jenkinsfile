node {
   wrap([$class: 'OpenShiftBuildWrapper',  
      installation: 'oc (latest)', 
      url: 'https://api.ocp4.smartek.ae:6443', 
      insecure: true, 
      credentialsId: 'openshift-cred']) { 
       sh 'oc version' 
   }
}
