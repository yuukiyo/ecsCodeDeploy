#!/usr/bin/env bash
set -e

application_name=$1
deployment_group_name=$2
container_name=$3
container_port=$4
task_definition_arn=$5

app_spec_content_string=$(jq -nc \
  --arg container_name "$container_name" \
  --arg container_port "$container_port" \
  --arg task_definition_arn "$task_definition_arn" \
  '{version: 1, Resources: [{TargetService: {Type: "AWS::ECS::Service", Properties: {TaskDefinition: $task_definition_arn, LoadBalancerInfo: {ContainerName: $container_name, ContainerPort: $container_port}}}}]}')
app_spec_content_sha256=$(echo -n "$app_spec_content_string" | shasum -a 256 | sed 's/ .*$//')
revision="revisionType=AppSpecContent,appSpecContent={content='$app_spec_content_string',sha256=$app_spec_content_sha256}"

aws deploy create-deployment \
  --application-name="$application_name" \
  --deployment-group-name="$deployment_group_name" \
  --revision="$revision"
