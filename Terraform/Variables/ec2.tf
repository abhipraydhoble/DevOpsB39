resource  "aws_vpc" "vpc-demo" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "vpc-demo"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vpc-demo.id
    cidr_block = var.aws_subnet[0]
    availability_zone = var.az[0]
    map_public_ip_on_launch = var.public_ip
    tags = {
        Name = "Public-Subnet"
    }
}

resource "aws_internet_gateway" "igw-demo" {

    vpc_id = aws_vpc.vpc-demo.id
    tags = {
        Name = "igw-demo"
    }
}

resource "aws_route_table" "RT-public" {
    vpc_id = aws_vpc.vpc-demo.id
    tags = {
        Name = "RT-public"
    }
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-demo.id
    }
}

resource "aws_route_table_association" "rt-public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.RT-public.id
}

resource "aws_security_group" "demo-sg" {
    name = "demo-sg"
    description = "allow ports ssh db tomcat and http to instance"
    vpc_id = aws_vpc.vpc-demo.id

    ingress {
        from_port = var.port_no[0]
        to_port = var.port_no[0]
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
      ingress {
        from_port = var.port_no[2]
        to_port = var.port_no[2]
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

      ingress {
        from_port = var.port_no[1]
        to_port = var.port_no[1]
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
      ingress {
        from_port = var.port_no[3]
        to_port = var.port_no[3]
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
      egress {
        from_port = var.port_no[4]
        to_port = var.port_no[4]
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "demo-sg"
    }
}


resource "aws_instance" "vm-nginx" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.demo-sg.id]
    key_name = var.key
    
    tags = {
        Name = "Nginx-Instance"
    }
}




