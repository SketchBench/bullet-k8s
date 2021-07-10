# bullet-k8s

Helm Chart for [Bullet](https://bullet-db.github.io/).

## Resources

### Forward Kubernetes Services to localhost

> The following commands assume a Helm Release called `my-bullet`.

#### Bullet UI

    kubectl port-forward service/my-bullet-ui 8800:8800

#### Bullet Web Service

    kubectl port-forward service/my-bullet-web-service 9999:9999

#### Bullet Spark Backend UI

    kubectl port-forward service/my-bullet-spark-backend-ui 4040:4040

#### Spark Web UI

    kubectl port-forward service/my-bullet-spark-master-svc 8000:80

#### HDFS Web UI

    kubectl port-forward service/my-bullet-hdfs 5070:50070

#### Kafdrop (Kafka Web UI)

Bullet PubSub:

    kubectl port-forward service/my-bullet-pubsub-monit 9000:9000

### Kubernetes Dashboard for local development

1. Add `kubernetes-dashboard` helm repo

        helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/

2. Install `kubernetes-dashboard` helm chart

    Unix:

        helm install \
        --namespace kubernetes-dashboard \
        --create-namespace \
        --set fullnameOverride=kubernetes-dashboard \
        --set protocolHttp=true \
        --set service.externalPort=8080 \
        kubernetes-dashboard \
        kubernetes-dashboard/kubernetes-dashboard

    Windows:

        helm install `
        --namespace kubernetes-dashboard `
        --create-namespace `
        --set fullnameOverride=kubernetes-dashboard `
        --set protocolHttp=true `
        --set service.externalPort=8080 `
        kubernetes-dashboard `
        kubernetes-dashboard/kubernetes-dashboard

3. Forward `kubernetes-dashboard` port to localhost

        kubectl port-forward -n kubernetes-dashboard service/kubernetes-dashboard 8000:8080

4. Profit

    Browse to `http://localhost:8000`

### Run `chart-testing` locally

#### Windows

`ct lint`:

    docker run --rm --volume ${PWD}:/src --workdir /src quay.io/helmpack/chart-testing:latest ct lint --config ct.yaml

Interactive:

    docker run --interactive --tty --rm --volume ${PWD}:/src --workdir /src quay.io/helmpack/chart-testing:latest bash
