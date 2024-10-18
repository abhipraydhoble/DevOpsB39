data "aws_ami" "image" {
  most_recent      = true
  owners           = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.6.20241010.0-kernel-6.1-x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}



resource "aws_instance" "vm" {
    ami = data.aws_ami.image.id
    instance_type = "t2.micro"
    key_name = "gargi"
}


output "ami_id" {
    value = aws_instance.vm.ami
  
}

resource "aws_s3_bucket" "test" { 
    bucket = "test-bucket-b39"
    
  
}
