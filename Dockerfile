FROM arbiterofcool/jdk8-baseimage-docker:latest
MAINTAINER Sean Chatman <xpointsh@gmail.com>

##### Installing Jenkins #####

RUN apt-get -y install wget git

RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y jenkins

VOLUME /var/lib/jenkins
VOLUME /var/lib/docker

RUN echo "/var/lib/jenkins" > /etc/container_environment/JENKINS_HOME

# Add jobs
ONBUILD ADD jobs /var/lib/jenkins/jobs

# Setup Jenkins daemon
ONBUILD RUN mkdir /etc/service/jenkins
ONBUILD ADD jenkins/run /etc/service/jenkins/run

# Here is where things start getting strange.

# Install basics.
RUN apt-get update -qq
RUN apt-get install -qqy iptables ca-certificates lxc

# Install Docker from Docker Inc. repositories.
RUN apt-get install -qqy apt-transport-https
RUN echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN apt-get update -qq
RUN apt-get install -qqy lxc-docker

# Install the magic wrapper.
ADD ./wrapdocker /etc/my_init.d/wrapdocker
RUN chmod +x /etc/my_init.d/wrapdocker

# Install pip and fig
RUN apt-get install -y python-pip
RUN pip install -U fig

# Clean up APT when done.
RUN apt-get clean && rm -rf /tmp/* /var/tmp/*
