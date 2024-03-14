#!/bin/sh
cd /tmp/input
TAG="${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}"
buildah --storage-driver vfs bud --isolation chroot -t ${TAG} .
cp /var/run/secrets/openshift.io/push/.dockercfg /tmp
(echo "{ \"auths\": " ; cat /var/run/secrets/openshift.io/push/.dockercfg ; echo "}") > /tmp/.dockercfg
buildah --storage-driver vfs push --tls-verify=false --authfile /tmp/.dockercfg ${TAG}