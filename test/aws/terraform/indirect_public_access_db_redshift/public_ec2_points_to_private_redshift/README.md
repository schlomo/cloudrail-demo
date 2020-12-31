In some instances, you may have a private resource deployed in a public subnet. For example, a Redshift database in a subnet that 
can route traffic to the Internet, as well as receive incoming traffic.

If the Redshift database doesn't have a Public IP, then no one can reach it, right?

That is true generally, however, if there's another resource in the same subnet that does have a public IP,
and that resource can reach the database, it is possible for an outside entity to eventually get to the database.

In the scenario we've built here, there's an EC2 instance that is publicly accessible, 
and that EC2 instance can access the database on its port. Which means, if someone hacks
the public EC2, they can get to the database.

What's even more important here is that it's possible that the database was created by one team,
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

Where the database is located too (without a public IP):
```hcl

resource "aws_redshift_subnet_group" nondefault {
  name = "nondefault"
  subnet_ids = [aws_subnet.nondefault_1.id, aws_subnet.nondefault_2.id]

}

resource "aws_redshift_cluster" "test" {
  cluster_identifier = "redshift-defaults-only"
  node_type = "dc2.large"
  master_password = "Test1234"
  master_username = "test"
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.publicly_accessible_sg.id]
  cluster_subnet_group_name = aws_redshift_subnet_group.nondefault.name
  publicly_accessible = false // Note that while the subnet itself has public access, the redshift is set NOT to have a public IP
}}
```

And there's connectivity between the EC2 and database.

And so, we get:
```
Rule: Ensure Redshift database is not accessible indirectly via a publicly accessible resource
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_redshift_cluster.test] (main.tf:103)
     Violating Resource: [aws_security_group.publicly_accessible_sg]  (main.tf:114)

     Evidence:
         Internet
             | Instance aws_instance.public_ins resides in subnet(s) that are routable to Internet Gateway
             | Instance has public IP address
             | Instance accepts incoming traffic on port 443
         Instance aws_instance.public_ins
             | Redshift DB: aws_redshift_cluster.test does not have a public IP address
             | Redshift cluster is on subnets: aws_subnet.nondefault_1, aws_subnet.nondefault_2
             | Redshift resides in same subnet as Instance aws_instance.public_ins
             | Redshift DB uses NACL`s aws_network_acl.ec2_nacl, aws_network_acl.redshift_eni2_nacl
             | Redshift is accessible from instance within public subnet
         Redshift aws_redshift_cluster.test
```