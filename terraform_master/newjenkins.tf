resource "aws_vpc" "jenkins-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "jenkins-vpc"
  }
}

resource "aws_subnet" "jenkins-subnet" {
  vpc_id                  = aws_vpc.jenkins-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "jenkins-subnet"
  }
}

resource "aws_internet_gateway" "jenkins-igw" {
  vpc_id = aws_vpc.jenkins-vpc.id

  tags = {
    Name = "jenkins-igw"
  }
}

resource "aws_route_table" "jenkins-route-table" {
  vpc_id = aws_vpc.jenkins-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins-igw.id
  }

  tags = {
    Name = "jenkins-route-table"
  }
}

resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  description = "Allow necessary inbound traffic for Jenkins"
  vpc_id      = aws_vpc.jenkins-vpc.id

  # Allow all outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_tls_https" {
  security_group_id = aws_security_group.jenkins-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.jenkins-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_jenkins_port" {
  security_group_id = aws_security_group.jenkins-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.jenkins-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_instance" "jenkins-master" {
  instance_type          = "t2.micro"
  key_name               = "terraformkp1"
  ami                    = "ami-04b4f1a9cf54c11d0"
  subnet_id              = aws_subnet.jenkins-subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  associate_public_ip_address = true

  user_data = <<EOF
#!/bin/bash
sleep 40
sudo apt-get update -y
sudo apt install openjdk-21-jdk -y
sudo apt update -y
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian
binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins --no-pager
EOF

  tags = {
    Name = "jenkins-master"
  }
}

resource "aws_instance" "jenkins-slave" {
  instance_type          = "t2.micro"
  key_name               = "terraformkp1"
  ami                    = "ami-04b4f1a9cf54c11d0"
  subnet_id              = aws_subnet.jenkins-subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  associate_public_ip_address = true

  user_data = <<EOF
#!/bin/bash
sleep 30
sudo apt-get update -y
sudo apt install openjdk-21-jdk -y
sudo apt update -y
sudo apt-get install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
EOF

  tags = {
    Name = "jenkins-slave"
  }
}

output "master_public_ip" {
  value = aws_instance.jenkins-master.public_ip
}

output "slave_public_ip" {
  value = aws_instance.jenkins-slave.public_ip
}


"jenkins" charset