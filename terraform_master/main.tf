variable "bucketname" {
    default= "examplebucket"
}
variable "bucket count"{
    type = number
    default = 2
}

e

terraform {
  backend "s3" {
    bucket = "my-new-terraform-backend62"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

resourse "aws_s3-bucket" "new" {
    bucketname = "newfile6525"
}

    bucketname = "newfile6525"
terraform destroy -target=aws_s3_bucket.newfile6525

variable "instance_type" {
    description = "type of ec2 instance"
    type= string
    default = "t2.micro" 
}

 resource "aws_instance" "web1"{

    instance_type = var.instance_type




cd


    resource "aws_s3_bucket" "app" {
        bucket = "newbuck9875jklh"
        count = var.bucket_count

    }


    

ami = "ami-05b10e08d247fb927"
instance_type = "t2.micro"
}
output "web_instance_ip" {
description = "Public IP of the deployed EC2 instance"
value = aws_instance.web.public_ip
}




resource "aws_s3_bucket" "newbucket35" {
  bucket = "my-new-terraform-backend62"  # Ensure the name is globally unique
}

resource "aws_s3_bucket" "new" {
  bucket = "newfile6525"  # Corrected attribute name
}        
          
         
 resource "aws_instance" "web1"{
    ami = "ami-12345"
   instance_type = var.instance_type
}     


    resource "aws_s3_bucket" "app" {
        bucket = "newbuck9875jklh"
        count = var.bucket_count


        :wq
        

        variable "enable_monitoring" {
    description = " enable monitoring"
    type= bool
    default = false
}

resource "aws_instance" "example" {
    ami = "ami-12345"
    instance_type = "t2.micro"
    monitoring = var.enable_monitoring
}

variable "bucket_names" {
type = list(string)
default = ["bucketlist111", "bucketlist222", "bucketlist333", "bucketlist444" ]
}

vi

resource "aws_s3_bucket" "listing" {
  
  
}

resource "aws_s3_bucket" "listing" {
  for_each = toset(var.bucket_names)  # Convert list to a set for iteration

  bucket = each.value
}



variable "amiid" {
type = map(string)
default = {
    us-east-1 = "ami-123456"
    us-west-1 = "ami-789456"
}

}default = "t2.micro"

E

resources "aws_instance" "new"{
    ami = "ami-123456"
    count = 2
    instance_type = "t2.micro"
    name = server (count.index)
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}



resource "aws_instance" "new" {
  ami           = "ami-123456"  # Replace with a valid AMI ID
  count         = 2
  instance_type = "t2.micro"

  tags = {
    Name = "server-${count.index}"
  }
}


vi "rajuuu" aws_subnet.main.id