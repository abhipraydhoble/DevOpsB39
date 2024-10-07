
```yaml

apiVersion: v1
kind: ConfigMap # Used to store non sensitive info like username,url etc
metadata:
  name: my-vars
data:
  DB_URL: "mydbinstance.c6c8dfghilnt.us-east-1.rds.amazonaws.com"
  DB_USERNAME: "admin"

--- 
# echo -n 'passws123' | base64
# echo -n 'bXlzZWNyZXRwYXNzd29yZA== ' | base64 --decode


apiVersion: v1
kind: Secret  # used to store sensitive info like password,token etc
metadata:
  name: db-secret
data:
  DB_PASSWORD: bXlzZWNyZXRwYXNzd29yZA==  

--- 

apiVersion: v1
kind: Pod
metadata:
  name: shubu 
spec:
  containers:
  - name: shubham
    image: mysql:5.7
      env:
        - name: DB_URL
          valueFrom:
            configMapKeyRef:
              name: my-vars
              key: DB_URL
        - name: DB_USERNAME
          valueFrom:
            configMapKeyRef:
              name: my-vars
              key: DB_USERNAME
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: DB_PASSWORD
```
