output "network" {
  description = "Network output by environment"
  value       = {
    vpc = {
      overview = var.network.vpc.overview
      id       = aws_vpc.global.id
      name     = aws_vpc.global.tags.Name
    }
    subnet = {
      zone_a = {
        overview = var.network.subnet.zone_a.overview
        id       = aws_subnet.zone_a.id
        name     = aws_subnet.zone_a.tags.Name
      }
      zone_b = {
        overview = var.network.subnet.zone_b.overview
        id       = aws_subnet.zone_b.id
        name     = aws_subnet.zone_b.tags.Name
      }
    }
    internet_gateway = {
      overview = var.network.internet_gateway.overview
      id       = aws_internet_gateway.global.id
      name     = aws_internet_gateway.global.tags.Name
    }
    security_group = {
      load_balancer = {
        overview = var.network.security_group.load_balancer.overview
        id       = aws_security_group.load_balancer.id
        name     = aws_security_group.load_balancer.name
      }
      server = {
        overview = var.network.security_group.server.overview
        id       = aws_security_group.server.id
        name     = aws_security_group.server.name
      }
    }
    load_balancer = {
      overview     = var.network.load_balancer.server.overview
      id           = aws_lb.server.id
      name         = aws_lb.server.name
      dns          = aws_lb.server.dns_name
      target_group = {
        overview = var.network.load_balancer.server.target_group.overview
        id       = aws_alb_target_group.server.id
        name     = aws_alb_target_group.server.name
      }
      listener = {
        overview = var.network.load_balancer.server.listener.overview
        id       = aws_lb_listener.server.id
        name     = aws_lb_listener.server.tags.Name
      }
    }
  }
}