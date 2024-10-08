### What is a DaemonSet?
  
**A DaemonSet ensures that a copy of a pod runs on all (or some) nodes in the cluster. 
  DaemonSets are perfect for running background tasks such as log collection, monitoring, and other node-specific services.**

**When to Use DaemonSets**
  
Use DaemonSets when you need to run a service on all or selected nodes in the cluster. 
This is particularly useful for node-level services that need to be present on every node.

- running a logs collection daemon on every node
- running a node monitoring daemon on every node

```yaml
 apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: app1
spec:
  selector:
    matchLabels:
      app: app1
  template:
    metadata:
      labels:
        app: app1
    spec:
      containers:
        - name: app1-container
          image: nginx
          ports:
            - containerPort: 80
  ```
