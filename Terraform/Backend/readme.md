```hcl
terraform {
  backend "s3" {
    bucket = "tf-backend-bucket"
    key = "backup/terraform.tfstate"
    region = "us-east-1"
  }
}
```

````
terraform init
````

**Remote To Local**

```hcl
terraform {
    backend "local" {
        path = "terraform.tfstate"

    }
}
```

````
terraform init -migrate-state
````
