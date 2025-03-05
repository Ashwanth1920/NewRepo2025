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
        