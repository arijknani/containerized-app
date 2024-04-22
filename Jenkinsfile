node {
    withEnv(["PATH+OC=${tool 'oc'}"]) {
        openshift.withCluster('openshift-cluster') {
            
            sh 'oc login -u arij -p openshift https://api.ocp4.smartek.ae:6443'
            echo "${openshift.raw('version').out}"
            echo "In project: ${openshift.project()}"
        }
    }
}
