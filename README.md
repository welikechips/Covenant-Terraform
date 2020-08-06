### Commands

Need to setup aws creds:
```
export AWS_ACCESS_KEY_ID=<ACCESS_KEY>
export AWS_SECRET_ACCESS_KEY=<AWS_SECRET>
```

```
terraform init
terraform validate
terraform plan (Only use to plan)


terraform apply -var-file="production.tfvars"
terraform destroy -var-file="production.tfvars"

terraform graph | dot -Tpng > images/graph.png

terraform destroy -var-file="production.tfvars" -target=aws_instance.redirector_http_1
```

### After provisioning is completed


On the C2 server, access Covenant at https://localhost:7443/. Go to listeners, and stop and delete the old listener. Then, create a new one. This time, set the "BindPort" to "443" and "UseSSL" to "True." Set the "URL" to include your domain name, and the "ConnectAddress" to be the public IP of your redirector. Be sure to include the export password for the certificate under "SSLCertificatePassword."

![Setting Up a listener](/images/setting-up-listener.png)

### Terraform Graph

![Setting Up a listener](/images/graph.png)

https://github.com/cobbr/Covenant/wiki/Using-The-API
