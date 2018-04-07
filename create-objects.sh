#!/bin/bash
oc project demo
oc adm policy add-scc-to-user privileged -z default -n demo

oc create -f is-welcome.json
oc create -f bc-welcome.json
oc create -f dc-welcome.json
#oc create -f dc-jenkins.json
oc set triggers dc/welcome --manual
oc create -f svc-welcome.json
oc create -f route-welcome.json
#oc secrets new-dockercfg docker-registry --docker-server=docker-registry-default.apps.ocp.tauil.org --docker-username=admin --docker-password=$(oc whoami -t) --docker-email=test@test.com
oc create secret docker-registry docker-registry --docker-server=172.30.1.1:500 --docker-username=$(oc whoami) --docker-password=$(oc whoami -t) --docker-email=test@test.com
oc create -f pipeline/pipeline-inspector.yml
oc create -f image-inspector-template.json
