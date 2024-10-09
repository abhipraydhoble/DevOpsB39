# DevOpsB39

## ingress demo url
https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/
# Ingress
- using Ingress, you can efficiently manage and route external traffic to your Kubernetes services,
- ensuring a streamlined and scalable infrastructure.
## Why Use Ingress?

### Simplified Traffic Management
- **Problem:** Managing multiple services' external access can be complex and resource-intensive.
- **Solution:** Ingress provides a single entry point for traffic, simplifying management.

### Efficient Resource Utilization
- **Problem:** Multiple LoadBalancers for each service are costly and inefficient.
- **Solution:** Ingress allows one LoadBalancer to handle multiple services, saving costs.

### Centralized Routing
- **Problem:** Scattered routing rules are hard to maintain.
- **Solution:** Ingress centralizes routing rules, making updates easier.

### Advanced Traffic Control
- **Problem:** Basic service types have limited routing capabilities.
- **Solution:** Ingress supports path-based and host-based routing, SSL/TLS termination, and more.

```sql
          +-----------------------+
          |   External Traffic    |
          +-----------------------+
                     |
                     v
          +-----------------------+
          |   Ingress Controller  |
          +-----------------------+
                     |
                     v
          +-----------------------+
          |    Ingress Resource   |
          |-----------------------|
          | - Host: app1.example.com -> Service 1 |
          | - Host: app2.example.com -> Service 2 |
          +-----------------------+
                     |
         +-----------+-----------+
         |                       |
         v                       v
+-----------------+     +-----------------+
|   Service 1     |     |   Service 2     |
|-----------------|     |-----------------|
| - Pod 1         |     | - Pod 3         |
| - Pod 2         |     | - Pod 4         |
+-----------------+     +-----------------+
```
