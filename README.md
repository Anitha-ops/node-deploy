# my test folder

Tools used,
Docker and docker hub dor container images.
Buildkite for build pipeline
Weave flux for auto deploy of new images to the cluster.
Shell script to deploy the new deployments and services in the kubernetes cluster.

For auto deploy using weave flux, we will have the deployment annotations different in both stage and prod.

Staging:
  annotations:
    flux.weave.works/tag.node-app: glob:staging_*
    flux.weave.works/automated: 'true'
Prod:
  annotations:
    flux.weave.works/tag.node-app: glob:release_*
    flux.weave.works/automated: 'true'

Steps to create and push the image to docker hub with buildkite pipeline,

Install npm with command "npm install"

Create a pipeline in buildkite UI and coonfigure it to run steps pipeline.yml in mytest folder.
This pipeline will do the following steps,
1. Build the docker image
2. Publish docker image to docker hub with staging Tag
Then using weave flux, the images can  be auto deployed in to environments which is staging here.
3. Wait for the pod to start in staging
4. Perform the requiried test on staging pod.
5. If tess pass, then Tag the production release image and promote it.
6. Flux will deploy the new image in prod cluster, wait for pod to start.
7. Perform testing on prod pod.



To deploy the image into the kubernetes cluster, connect to your kubernetes cluster and then run the deploy.sh script which will create namespace, deployment and service.

Validate the deployment using the commands,
kubectl get ns (check if namespace technical-test is created)
kubectl get deploy -n technical-test (new deployment names node-app should bee listed and status should be 1/1 READY)
kubectl get pods -n technical-test (new pod names node-app should be running)

The Application will be running on cluster port 31219. 
Validation URL - https://cluster-path:31219/version
