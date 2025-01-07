#Server EC2
resource "aws_instance" "python_app" {
  ami                    = "ami-0fff1b9a61dec8a5f"
  instance_type          = "t3.small"
  key_name               = "vockey"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id = aws_subnet.public_subnet.id
  #user_data = file("./ec2_user_data.sh")
associate_public_ip_address = true
  tags = {
    Name = "python_app"
  }
}

#CICD EC2
resource "aws_instance" "cicd_ec2" {
  ami                    = "ami-0fff1b9a61dec8a5f"
  instance_type          = "t2.micro"
  key_name               = "vockey"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id = aws_subnet.public_subnet.id
  #user_data = file("./cicd_user_data.sh")
associate_public_ip_address = true
  tags = {
    Name = "cicd_ec2"
  }
}

#Security Group
resource "aws_security_group" "ec2_sg" {
  name   = "ec2_sg"
  vpc_id = aws_vpc.project-vpc.id
  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  # ingress {
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  # ingress {
  #   from_port   = 6443
  #   to_port     = 6443
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_s3_bucket" "s3" {
#   bucket = "my-pro-tf-test-bucket"

#   tags = {
#     Name        = "My bucket"
#   }
# }