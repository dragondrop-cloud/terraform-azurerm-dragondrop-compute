# terraform-azurerm-dragondrop-compute
## Note: We are actively building the initial release of this module in public!

Module for self-hosting a dragondrop Job within your Azure cloud environment

Available for consumption via HashiCorp's Public Module Registry: https://registry.terraform.io/modules/dragondrop-cloud/dragondrop-compute/azurerm/latest

# dragondrop Self-Hosting Compute
Terraform code for deploying the compute resources needed to run dragondrop.cloud within your Azure environment.

Cloud architecture diagram of the infrastructure created by this module.

## Variables

| Name                                    | Type        | Purpose                                                                                         |
|-----------------------------------------|-------------|-------------------------------------------------------------------------------------------------|
| _**https_trigger_azure_function_name**_ | string      | Name of the Azure function created by the Terraform Module which services as an HTTPS endpoint. |
| **_region_**                            | string      | Azure region into which resources should be deployed.                                           |
| **_resource_group_name_**               | string      | Name of the resource group into which the resources from this module are to be deployed.        |
| **_tags_**                              | map(string) | An optional mapping of tags to add to resources created by the module.                          |


## How to Use this Module
This module defines the compute resources needed to run dragondrop within your own Azure cloud environment.

It defines a [Azure Function](https://github.com/dragondrop-cloud/azure-container-instance-https-trigger) that can
evoke the longer running dragondrop engine living in a provisioned Azure Container Instance.

The url for this Azure Function is output and should be passed to a dragondrop [Job](https://docs.dragondrop.cloud/product-docs/getting-started/creating-a-job)
definition as that Job's "HTTPS Url".

The Azure Container Instance hosts dragondrop's proprietary container. All environment variables that need to be configured are references
to secrets within Azure Key Vault, and can be customized like any other secret.

### Security When Using This Module
This module creates a new IAM role, "dragondrop HTTPS Trigger Role" which has the minimum permissions needed to evoke
the created Azure Container Instance. This role is assigned to a new service account, and that service account is the service account
used by the Azure Function.

Lastly, another service account is granted Secret Accessor privileges on only the secrets referenced by the Azure Container Instance as
environment variables.

## What is dragondrop.cloud?
[dragondrop.cloud](https://dragondrop.cloud) is a provider of IAC automation solutions that are self-hosted
within customer's cloud environment. For more information or to schedule a demo, please visit our website.

## What's a Module?
A Module is a reusable, best-practices definition for the deployment of cloud infrastructure.
A Module is written using Terraform and includes documentation, and examples.
It is maintained both by the open source community and companies that provide commercial support.

## How can I contribute to this module?
If you notice a problem or would like some additional functionality, please open a detailed issue describing
the problem or open a pull request.

### License
Please see [LICENSE](LICENSE) for details on this module's license.

Copyright © 2023 dragondrop.cloud, Inc.
