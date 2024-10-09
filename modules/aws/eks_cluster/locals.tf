locals {
  kubeconfig = templatefile("${path.module}/templates/kubeconfig.tpl", {
    kubeconfig_name                   = module.cluster.cluster_name
    endpoint                          = coalescelist(module.cluster.endpoint, [""])[0]
    cluster_auth_base64               = coalescelist(module.cluster.certificate_authority[0].data, [""])[0]
    aws_authenticator_command         = var.kubeconfig_aws_authenticator_command
    aws_authenticator_command_args    = length(var.kubeconfig_aws_authenticator_command_args) > 0 ? var.kubeconfig_aws_authenticator_command_args : ["token", "-i", coalescelist(module.cluster.cluster_name, [""])[0]]
    aws_authenticator_additional_args = var.kubeconfig_aws_authenticator_additional_args
    aws_authenticator_env_variables   = var.kubeconfig_aws_authenticator_env_variables
  })
}