# Quick and dirty set up of a web server and a RDS MySql Database

### The setup is split up into 1 module and multiple files. The EC2 resources were setup in one file and the RDS setup was in a seperate file
### Variables are best practice so there are some variables in the variables.tf file
### The module contains the ELB and the output is the dns name of the elb  