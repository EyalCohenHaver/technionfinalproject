#CICD EC2
resource "aws_instance" "cicd_ec2" {
  ami                    = "ami-0fff1b9a61dec8a5f"
  instance_type          = "t2.micro"
  key_name               = "vockey"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id = aws_subnet.public_subnet.id
#  user_data = file("./ec2_user_data.sh")
associate_public_ip_address = true
  tags = {
    Name = "cicd_ec2"
  }
}