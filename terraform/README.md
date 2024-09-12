# Canoe DevOps Tech Assessment

Demonstrate familiarity with Docker containers and some software development skills.

**Requested**
> Terraform to build the following in a single AWS region. Does not have to be deployed to AWS by the candidate as to not incur charges,
but we do expect a terraform plan to work on this Terraform code. We will be checking the syntax for correctness and demonstrated
understanding how Terraform and the AWS provider works

This Terraform module was created and validated using [LocalStack](https://www.localstack.cloud/) with a free plan, which does not support some AWS features, such as ECR, ELBv2, and ECS.

Part of this documentation was generated using [terraform-docs](https://github.com/terraform-docs/terraform-docs) and can be regenerated or updated with the following command:

```bash
terraform-docs markdown table --output-file README.md --output-mode inject .
```


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.66.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.13.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.imported_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_cloudwatch_log_group.ecs_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecr_repository.service_repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecs_cluster.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lb.ecs_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.ecs_service_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.lb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_containerPort"></a> [containerPort](#input\_containerPort) | Port where the applicatino is running in the container | `number` | `8000` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | CPU available for the task | `string` | `"256"` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | The number of instances of the task definition to place and keep running | `number` | `1` | no |
| <a name="input_ecs_service_deployment_maximum_percent"></a> [ecs\_service\_deployment\_maximum\_percent](#input\_ecs\_service\_deployment\_maximum\_percent) | The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment | `number` | `200` | no |
| <a name="input_ecs_service_deployment_minimum_healthy_percent"></a> [ecs\_service\_deployment\_minimum\_healthy\_percent](#input\_ecs\_service\_deployment\_minimum\_healthy\_percent) | The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment | `number` | `50` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | RAM memory available for the task | `string` | `"512"` | no |
| <a name="input_name"></a> [name](#input\_name) | Service name. It'll be used in several places | `string` | `"api-service"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to use on all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_service"></a> [ecs\_service](#output\_ecs\_service) | ECS Service ID |
| <a name="output_task"></a> [task](#output\_task) | ECS Task ID |
| <a name="output_task_cluster"></a> [task\_cluster](#output\_task\_cluster) | ECS Task Cluster ID |
<!-- END_TF_DOCS -->