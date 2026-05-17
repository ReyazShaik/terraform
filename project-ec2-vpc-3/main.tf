resource "aws_vpc" "myvpc" {
    cidr = "192.168.0.0/24"
    tags {
        Name = myvpc
    }
}

resouce "aws_subnet" "sub1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "192.168.1.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    tags {
        Name = sub1
    }
}

resouce "aws_subnet" "sub2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "192.168.2.0/24"
    availability_zone = "ap-south-ab"
    map_public_ip_on_launch = true
    tags {
        Name = sub2
    }
}

resouce "aws_internet_gateway" "myigw" {
    vpc_id = "aws_vpc.myvpc.id
}

resouce "aws_route_table" "myroutetable" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myigw.id
    }
}

resouce "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.sub1.id
    route_table_id = aws_route_table.myroutetable.id
}

resouce "aws_route_table_association" "rta2" {
    subnet_id = aws_subnet.sub2.id
    route_table_id = aws_route_table.myroutetable.id
}

resouce "aws_security_group" "mysg" {
    name = "web"
    vpc_id = aws_vpc.myvpc.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = HTTP
        cidr_blocks  = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocal = SSH
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to port = 0
        protocal = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "web-sg"
    }
}

resouce "aws_instance" "myinstance1" {
    ami = "sdfsdfs"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.mysg.id]
    subnet_id = aws_subnet.sub1.id
    key_name = "4PMBATCH"
    user_data = base64encod(file("userdata.sh"))

    tags {
        Name = dev-server1
    }
}

resouce "aws_instance" "myinstance2" {
    ami = "fsdfs"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.mysg.id]
    subnet_id = aws_subnet.sub2.id
    key_name = 4PMBATCH
    user_data = base64encode(file("userdata1.sh"))
tags {
    Name = dev-server2
}

}
