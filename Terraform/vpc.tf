resource "aws_vpc" "vnet" {
    cidr_block = "192.168.0.0/16"
    tags = {
        Name = "vpc-b39"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vnet.id
    cidr_block = "192.168.0.0/22"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "Public-Subnet-Nginx"
    }
}


resource "aws_subnet" "pri-tom" {
    vpc_id = aws_vpc.vnet.id
    cidr_block = "192.168.4.0/22"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false
    tags = {
        Name = "Private-Subnet-Tom"
    }
}




resource "aws_internet_gateway" "net" {
    vpc_id = aws_vpc.vnet.id

    tags = {
        Name = "igw-b39"
    }
}


resource "aws_route_table" "rt-pub" {
    vpc_id = aws_vpc.vnet.id
    tags = {
        Name = "RT-Public"
    }

    route {
        gateway_id = aws_internet_gateway.net.id 
        cidr_block = "0.0.0.0/0"
    }
  
}

resource "aws_route_table_association" "rt-attach" {
   subnet_id = aws_subnet.public.id
   route_table_id = aws_route_table.rt-pub.id
}


resource "aws_eip" "dynamic" {
    domain = "vpc"
  
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.dynamic.id
    subnet_id = aws_subnet.pri-tom.id
  
}

resource "aws_route_table" "rt-pri-1" {
    vpc_id = aws_vpc.vnet.id
    tags = {
        Name = "RT-Private-Tom"
    }

    route   {
        nat_gateway_id = aws_nat_gateway.nat.id
        cidr_block = "0.0.0.0/0"
    }
  
}

resource "aws_route_table_association" "rt-2" {
    subnet_id = aws_subnet.pri-tom.id
    route_table_id = aws_route_table.rt-pri-1.id
  
}

resource "aws_security_group" "sg" {
    name = "ag-b39"
    vpc_id = aws_vpc.vnet.id
    tags = {
        Name = "security-group-39"
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_instance" "web" {
    ami = "ami-06b21ccaeff8cd686"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name = "App-Server"
    }
}

resource "aws_instance" "web2" {
    ami = "ami-06b21ccaeff8cd686"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.pri-tom.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name = "Tomcat-Server"
    }
}
