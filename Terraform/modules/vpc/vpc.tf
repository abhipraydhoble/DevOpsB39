resource "aws_vpc" "network" {
    cidr_block = var.vpc_cidr_block
    tags = {
         Name = "VPC-39"
    }
}

resource "aws_subnet" "sub-1" {
  vpc_id = aws_vpc.network.id 
  cidr_block = var.aws_subnet[0]
  availability_zone = var.az[0]
  map_public_ip_on_launch = var.public_ip 
 
  tags = {
    Name = "Public-subnet"
  }

}


resource "aws_internet_gateway" "www" {
    vpc_id = aws_vpc.network.id 
    tags = {
        Name = "igw-v39"
    }
  
}

resource "aws_route_table" "rt-pub" {
    vpc_id = aws_vpc.network.id 
    tags = {
        Name = "RT-Public"
    }
   
   route {
    gateway_id = aws_internet_gateway.www.id 
    cidr_block = "0.0.0.0/0"
   }
}

resource "aws_route_table_association" "attach" {
    subnet_id = aws_subnet.sub-1.id 
    route_table_id = aws_route_table.rt-pub.id
  
}


resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.network.id 
    tags = {
        Name = "aws-security-group"
        Environment = "Dev"
    }

    ingress {
        from_port = var.port_no[0]
        to_port = var.port_no[0]
        protocol = "tcp" 
        cidr_blocks = ["0.0.0.0/0"]
    }
     egress {
        from_port = var.port_no[1]
        to_port = var.port_no[1]
        protocol = "-1" 
        cidr_blocks = ["0.0.0.0/0"]
    }
}



