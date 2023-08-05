resource "aws_security_group" "test_sg" {
  name   = "test-sg"
  vpc_id = aws_vpc.vpc.id

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

resource "aws_instance" "test_instance" {
  ami           = "ami-00d253f3826c44195"
  instance_type = "t3.micro"
  key_name      = "example-key-pair"

  availability_zone = "ap-northeast-2a"
  subnet_id         = aws_subnet.public_1.id

  vpc_security_group_ids = [
    aws_security_group.test_sg.id
  ]
  associate_public_ip_address = true
}
