resource "aws_ecs_cluster" "server" {
  name = local.compute.server.cluster.name
}
