 resource "aws_instance" "ec2" {
   ami = lookup(var.ec2_ami,var.region)
   instance_type = var.instancetype
   subnet_id = aws_subnet.public_subnet.1.id
   vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
   associate_public_ip_address = "false"
   key_name  = var.key_name
   user_data = <<EOF
    #!/bin/bash
    sudo yum update –y
    sudo wget -O /etc/yum.repos.d/jenkins.repo  https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    sudo yum upgrade
    sudo amazon-linux-extras install java-openjdk11 -y
    sudo yum install jenkins -y
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    sudo cat /etc/sudoers.d/90-cloud-init-users >> /tmp/90-cloud-init-users
    sudo echo -e "jenkins ALL=(ALL) NOPASSWD:ALL"  >> /tmp/90-cloud-init-users
    sudo cp  /tmp/90-cloud-init-users /etc/sudoers.d/90-cloud-init-users    
    sudo yum install -y yum-utils   
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    sudo yum -y install terraform
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword >> /home/ec2-user/Jpassword.txt
   EOF
   
   
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
