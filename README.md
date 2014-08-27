# A Jenkins daemon running in the phusion/baseimage-docker image

jenkins-baseimage-docker is a special [Docker](http://www.docker.io) image that follows the best-practices set by [Baseimage-docker](https://github.com/phusion/baseimage-docker).

 * Downloads [Jenkins](http://jenkins-ci.org/) within the Dockerfile.
 * Daemon started by [runit](http://smarden.org/runit/).
 * Downloads [Jenkins plugins](http://updates.jenkins-ci.org/download/plugins/) specified in /jenkins/run (Commented out)
 * Uses `setuser` to create jenkins user.
