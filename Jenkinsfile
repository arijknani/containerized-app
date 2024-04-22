node('agent') {
    withEnv(["PATH+OC=${tool 'oc'}"]) {
        openshift.withCluster( 'openshift-cluster' ) {
            echo "${openshift.raw( "version" ).out}"
            echo "In project: ${openshift.project()}"
        }
    }
}
