# bullet-k8s

## Resources

### Forward Kubernetes Services to localhost

#### Bullet UI

    kubectl port-forward service/bullet-ui 8800:8800

#### Bullet Web Service

    kubectl port-forward service/bullet-web-service 9999:9999

#### Bullet Spark Backend UI

    kubectl port-forward service/bullet-spark-backend-ui 4040:4040

#### Spark Web UI

    kubectl port-forward service/bullet-spark-master-svc 8000:80

#### HDFS Web UI

    kubectl port-forward service/bullet-hdfs 5070:50070

#### Kafdrop (Kafka Web UI)

Bullet PubSub:

    kubectl port-forward service/bullet-pubsub-monit 9000:9000

Bullet Data Ingestion:

    kubectl port-forward service/bullet-data-ingestion-monit 9001:9000

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
