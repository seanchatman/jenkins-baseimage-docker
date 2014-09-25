#!/bin/sh
PLUGINS_ENDPOINT=http://updates.jenkins-ci.org/latest/
DATA=/var/lib/jenkins

mkdir -p $DATA/plugins

if find $DATA/plugins -maxdepth 0 -empty | read v; then
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/credentials.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/ssh-credentials.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/ssh-agent.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/git-client.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/git.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/scm-api.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/postbuild-task.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/job-dsl.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/startup-trigger-plugin.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/docker-build-step.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/docker-plugin.hpi)
fi

chown -R jenkins $DATA