# K8s Volumes Types

1. EmptyDir
2. HostPath
3. Persistent Volume
4. Persistent Volume Claim


**EmptyDir**
- EmptyDir is used for temporary purpose
- whenever new pod will get create an EmptyDir volume will be assigend
- if the pod is terminated the volume will also get deleted
  
````
apiVersion: v1
kind: Pod
metadata:
  name: emptydir-pod
spec:
  containers:
  - name: my-container
    image: nginx
    volumeMounts:
    - mountPath: /usr/share/nginx/html
      name: my-emptydir
  volumes:
  - name: my-emptydir
    emptyDir: {}
````
