apiVersion: v1
kind: Config

clusters:
- cluster:
    server: ${endpoint}
    certificate-authority-data: ${cluster_auth_base64}
  name: ${kubeconfig_name}

users:
- name: arn:aws:eks:us-east-1:931627500555:cluster/platform2-cluster-eks
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - --region
      - us-east-1
      - eks
      - get-token
      - --cluster-name
      - platform2-cluster-eks
      - --output
      - json
      command: aws

contexts:
- context:
    cluster: ${kubeconfig_name}
    user: ${kubeconfig_name}
  name: ${kubeconfig_name}

current-context: ${kubeconfig_name}


kubeconfig_name: ${kubeconfig_name}
endpoint:  ${endpoint}
cluster_auth_base64: ${cluster_auth_base64}
aws_authenticator_command: ${aws_authenticator_command}
aws_authenticator_command_args: ${aws_authenticator_command_args}
aws_authenticator_additional_args: ${aws_authenticator_additional_args}
aws_authenticator_env_variables: ${aws_authenticator_env_variables}