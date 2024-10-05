# K8s Volumes Types

1. EmptyDir
2. HostPath
3. Persistent Volume
4. Persistent Volume Claim


**EmptyDir**
- EmptyDir is used for temporary purpose
- whenever new pod will get create an EmptyDir volume will be assigend
- if the pod is terminated the volume will also get deleted
  
```yaml
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
```

**HostPath**
- mount local directory to pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hostpath-pod
spec:
  containers:
  - name: my-container
    image: nginx
    volumeMounts:
    - mountPath: /usr/share/nginx/html
      name: my-hostpath
  volumes:
  - name: my-hostpath
    hostPath:
      path: /data/nginx
      type: DirectoryOrCreate
```

**PersistentVolume**
- It provides permanent storage for pods outside of its lifecycle
  
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-example
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: "/mnt/data"
```

**PVC**
- to access PV PVClaim needs to be created

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-example
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: manual
---
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: myfrontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: pv-example
  volumes:
    - name: pv-example
      persistentVolumeClaim:
        claimName: pvc-example
```
