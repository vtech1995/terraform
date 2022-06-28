 resource "aws_instance" "ec2" {
   ami = lookup(var.ec2_ami,var.region)
   instance_type = var.instancetype
   subnet_id = aws_subnet.public_subnet.1.id
   vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
   associate_public_ip_address = "true"
   key_name  = var.key_name

   
   tags = {
     Name = "Master-${var.region}"
  }
 }


#resource "aws_instance" "ec2_worker1" {
#   ami = lookup(var.ec2_ami,var.region)
#   instance_type = var.instancetype
#   subnet_id = aws_subnet.public_subnet.1.id
#   vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
#   associate_public_ip_address = "true"
#   key_name  = var.key_name
#
#   
#   tags = {
#     Name = "Worker-${var.region}"
#  }
# }

# resource "aws_instance" "ec2_worker2" {
#    ami = lookup(var.ec2_ami,var.region)
#    instance_type = var.instancetype
#    subnet_id = aws_subnet.public_subnet.1.id
#    vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
#    associate_public_ip_address = "true"
#    key_name  = var.key_name

   
#    tags = {
#      Name = "Worker2-${var.region}"
#   }
#  }
