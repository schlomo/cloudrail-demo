In some instances, you may have a private resource deployed in a public subnet. For example, an RDS database in a subnet that 
can route traffic to the Internet, as well as receive incoming traffic.

If the RDS database doesn't have a Public IP, then no one can reach it, right?

That is true generally, however, if there's another resource in the same subnet that does have a public IP,
and that resource can reach the RDS database, it is possible for an outside entity to eventually get to the database.

In the scenario we've built here, there's an EC2 instance that is publicly accessible, 
and that EC2 instance can access the RDS database on port 3306. Which means, if someone hacks
the public EC2, they can get to the database.

What's even more important here is that it's possible that the RDS database was created by one team,
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

Where the RDS is located too (without a public IP):
```hcl
resource "aws_db_subnet_group" "db" {
  name = "rds_db"
  subnet_ids = [aws_subnet.nondefault_1.id, aws_subnet.nondefault_2.id]

}

resource "aws_db_instance" "test" {
  identifier = "tf-test-db"
  allocated_storage = "5"
  multi_az = "false"
  engine = "mysql"
  instance_class = "db.t2.small"
  username = "admin"
  password = "password123"
  db_subnet_group_name = aws_db_subnet_group.db.name
  vpc_security_group_ids = [ aws_security_group.db.id]
  storage_type = "gp2"
  skip_final_snapshot = true
  publicly_accessible = false
}
```

And there's connectivity between the EC2 and RDS:
```hcl
resource "aws_security_group" "db" {
  vpc_id = aws_vpc.nondefault.id
  ingress {
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    cidr_blocks = [aws_subnet.nondefault_1.cidr_block]
  }
}
```

And so, we get:
```
Rule: Ensure RDS database is not accessible indirectly via a publicly accessible resource
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_db_instance.test] (main.tf:113)
     Violating Resource: [aws_security_group.db]  (main.tf:103)

     Evidence:
         Internet
             | Instance resides in subnet(s) that are routable to Internet Gateway
             | Instance has Public IP address
             | Instance accepts incoming traffic on port 443
         Instance aws_instance.public_ins
             | RDS instance aws_db_instance.test does not have Public IP associated
             | RDS instance is on subnets: aws_subnet.nondefault_1, aws_subnet.nondefault_2
             | RDS resides in same subnet as instance aws_instance.public_ins.id
             | RDS relies on NACL's aws_network_acl.ec2_nacl, aws_network_acl.redshift_eni2_nacl
             | RDS also relies on security groups aws_security_group.db
             | RDS is accessible from instance within public subnet
         RDS
```