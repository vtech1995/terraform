resource "aws_instance" "ec2" {
   ami = lookup(var.ec2_ami,var.region)
   instance_type = var.instancetype
   subnet_id = aws_subnet.public_subnet.1.id
   vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
   associate_public_ip_address = "false"
   key_name  = var.key_name
   iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup" 
   user_data = <<EOF
    #!/bin/bash
    sudo yum install git -y
    sudo git clone https://github.com/vtech1995/jenkin-lab.git /home/ec2-user/deployment
    sudo amazon-linux-extras install ansible2
    ansible-playbook /home/ec2-user/deployment/deployment.yml >> /home/ec2-user/out.txt
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    sudo yum -y install terraform 
    EOF
   
   tags = {
     Name = "Master-Jenkins-${var.region}"
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
