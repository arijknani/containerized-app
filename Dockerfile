#define the env of the app
#pulling the base
FROM registry.redhat.io/rhel8/buildah
#add the sample Dockerfile
ADD dockerfile.sample /tmp/input/Dockerfile
#add the build script
ADD build.sh /usr/bin
#run the build script
RUN chmod a+x /usr/bin/build.sh
ENTRYPOINT ["/usr/bin/build.sh"]
