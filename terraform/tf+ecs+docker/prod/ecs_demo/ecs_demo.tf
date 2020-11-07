module "seminar" {
  source                              = "../modules/my_instance"
  id                                  = "seminar"
  name                                = "seminar"
  instance_type                       = "t3a.xlarge"
  aws_route53_zone_id                 = "${aws_route53_zone.movercado.zone_id}"
  my_instance_disable_api_termination = false
  vpc_security_group_ids              = var.seminar_vpc_security_group_ids
  my_instance_iam_instance_profile    = "AmazonEC2RoleforSSM"

  disks = [
    {
      "name" = "/dev/sdf",
      "size" = 1000,
      "label" = "opt"
    }
  ]
}
