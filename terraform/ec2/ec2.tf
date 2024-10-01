    resource "aws_security_group" "allow_ssh_terraform" {
        name        = "allow_sshh" #allow_ssh is already there in my account
        description = "Allow port number 22 for SSH access"

        # usually we allow everything in egress
        egress {
            from_port        = 0
            to_port          = 0
            protocol         = "-1"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
        }

        ingress {
            from_port        = 22
            to_port          = 22
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"] #allow from everyone
            ipv6_cidr_blocks = ["::/0"]
        }

        tags = {
            Name = "allow_sshh"
        }
    }
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with the appropriate AMI ID
  instance_type = "t3.micro"

  # Attach the security group to the instance
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]

  tags = {
    Name = "MyEC2Instance"
  }

  # Add any other necessary configurations such as key_name, subnet_id, etc.
}
