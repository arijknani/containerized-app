node('openshift-agent') {
    withEnv(["PATH+OC=${tool 'oc1.3.2'}"]) {
        openshift.withCluster( 'mycluster' ) {
            echo "${openshift.raw( "version" ).out}"
            echo "In project: ${openshift.project()}"
        }
    }
}


node {
   wrap([$class: 'OpenShiftBuildWrapper',  
      installation: 'oc (latest)', 
      url: 'https://api.ocp4.smartek.ae:6443', 
      insecure: true, 
      credentialsId: 'openshift-cred']) { 
       sh 'oc version' 
   }
}
