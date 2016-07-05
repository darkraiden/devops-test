# DevOps test

## Description

A small automated script that spins up an AWS EC2 instance and installs nginx server

## Before you start

This script will check if the aws CLI is installed on your computer; if not, it'll take care of it! Here follows some basic instructions on how to prepare your machine to run this script.

### Clone the repo

CD into your favorite `wip` directory and type:

```
$ git clone git@github.com:davidedimauro88/devops-test.git
```

Then:

```
$ cd devops-test
```

### Set your AWS credentials

Before you start, you have to make sure that your AWS credentials are set as environment variables:

```
$ export AWS_ACCESS_KEY_ID="yourAwsAccessKey"
$ export AWS_SECRET_ACCESS_KEY="yourAwsSecretKey"
```

### SSH key path and AWS key name

The script, after the EC2 instance creation, will need to ssh to the server using the paired with your AWS account. To do so, edit the script `start.sh` and add the ssh key path to the environment variable `SSH_KEY` and the name of the AWS key name at line 3 and 4.

eg:

```
#!/bin/bash

AWS_KEY=nameOfAwsPublicKey
SSH_KEY=/home/user/.ssh/mySecretKey.pem
```

### Make the script executable

Make sure that your script is executable by typing:

```
$ chmod +x start.sh
```

### Run the script

All is set, we can run the script:

```
$ ./start.sh
```
