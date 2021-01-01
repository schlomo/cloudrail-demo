Some organizations wants to make sure that public AMIs are never used. They want to enforce that only private AMIs are used, ones that were approved for use.

Cloudrail employs a compilcated logic to map out the organiations AMIs, as well as the public AMIs available, and determines what type of AMI each EC2 is set to use.

In this scenario, we've simulated a case where an EC2 is set to use a public AMI:
```hcl
resource "aws_instance" "public-ubuntu-from-data" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  
  tags = {
    Name = "public-ubuntu-from-data"
  }
}
```

And Cloudrail flags it:

```
-----------------------------------------------
Rule: Allow only private AMIs to be used
 - 1 Resources Exposed:
-----------------------------------------------
   - Exposed Resource: [aws_instance.public-ubuntu-from-data] (main.tf:98)
     Violating Resource: [ami-099e921e69356cf89]  (Not found in TF)

     Evidence:
             | The EC2 aws_instance.public-ubuntu-from-data uses AMI ami-099e921e69356cf89, which is public

```