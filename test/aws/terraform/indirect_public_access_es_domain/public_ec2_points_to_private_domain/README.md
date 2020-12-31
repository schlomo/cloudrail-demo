In some instances, you may have a private resource deployed in a public subnet. For example, an Elasticsearch Domain in a subnet that 
can route traffic to the Internet, as well as receive incoming traffic.

If the Elasticsearch Domain doesn't have a Public IP, then no one can reach it, right?

That is true generally, however, if there's another resource in the same subnet that does have a public IP,
and that resource can reach the Elasticsearch Domain, it is possible for an outside entity to eventually get to the Elasticsearch Domain.

In the scenario we've built here, there's an EC2 instance that is publicly accessible, 
and that EC2 instance can access the Elasticsearch Domain on its port. Which means, if someone hacks
the public EC2, they can get to the Elasticsearch Domain.

What's even more important here is that it's possible that the Elasticsearch Domain was created by one team,
and the EC2 instance by another, and they're unaware of each other's resources. Cloudrail _is_ aware, because
we scan the cloud environment and merge it with the Terraform plan.

Public EC2:
```hcl
resource "aws_instance" "public_ins" {
  ami = "ami-0130bec6e5047f596"
  instance_type = "t3.nano"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.publicly_accessible_sg.id]
  subnet_id = aws_subnet.nondefault_1.id
}
```

Is on a subnet with Internet access:
```hcl
resource "aws_subnet" "nondefault_1" {
  vpc_id = aws_vpc.nondefault.id
  cidr_block = "10.1.1.128/25"
  availability_zone = "eu-central-1a"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nondefault.id
}

resource aws_route_table "nondefault_1" {
  vpc_id = aws_vpc.nondefault.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "nondefault_1" {
  route_table_id = aws_route_table.nondefault_1.id
  subnet_id = aws_subnet.nondefault_1.id
}
```

Where the Elasticsearch Domain is located too (without a public IP):
```hcl
resource "aws_elasticsearch_domain" "test" {
  domain_name = "test"
  vpc_options {
    subnet_ids = [aws_subnet.nondefault_1.id]
    security_group_ids = [aws_security_group.esdomain.id]
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
    volume_type = "gp2"
  }
}
```

And there's connectivity between the EC2 and database:
```hcl
resource "aws_security_group" "esdomain" {
  vpc_id = aws_vpc.nondefault.id
  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = [aws_subnet.nondefault_1.cidr_block]
  }
}
```

And so, we get:
```

```