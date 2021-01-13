This is a bit of a different test case. Here, you have a variable in use. The default value of this variable will not 
cause any issues. However, if someone overrides the variable in runtime, it could.

So, try running Cloudrail against the main.tf first with no variable changes. Then, try running it like this:

```
# terraform plan -out=plan.out -var="source_cidr=0.0.0.0/0"
```

Now, Cloudrail will find a violation, because you've changed the source_cidr.