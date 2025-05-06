apiVersion: apps/v1
kind: Deployment
metadata:
  name: python-app
  namespace: app-ns
spec:
  selector:
    matchLabels:
      run: python-app
  template:
    metadata:
      labels:
        run: python-app
    spec:
      tolerations:
      - key: node.kubernetes.io/os
        operator: Equal
        value: linux
      nodeSelector:
        cloud.google.com/gke-nodepool: application-node-pool
      serviceAccountName: python-app-sa
      containers:
      - image: us-central1-docker.pkg.dev/personal-project-1-458808/application-repo/todo-app:latest
        name: python-app-app
        ports:
        - containerPort: 5000
          protocol: TCP
        resources:
          requests:
            cpu: 128m
            memory: 258Mi
          limits:
            cpu: 256m
            memory: 258Mi
