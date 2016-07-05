#!/bin/bash

AWS_KEY=awsPublicKey
SSH_KEY=pathToYourKey

echo "Check if aws cli is installed..."

aws --version

if [ $? -ne 0 ]; then
    echo "aws cli is not installed! Installing it now..."
    sudo apt-get update \
    && sudo apt-get install python-pip \
    && sudo pip install awscli
fi

echo "Create EC2 instance..."

#Spin up an EC2 instance using an Ubuntu-14.04 AMI
aws ec2 run-instances --image-id ami-939bb4e4 --count 1 --instance-type t2.micro --key-name $AWS_KEY --security-groups default > tempFile #Print the aws json out to a temp file

sleep 60 #Wait until instance is ready

#Save the instance ID to a variable
ID=$(cat tempFile | grep InstanceId | awk '{ print $2 }' | sed s/\"//g | sed s/\,//g)

#Describe instance to get ip
aws ec2 describe-instances --filters "Name=instance-id,Values=$ID" > tempFile

#Save public IP address to a variable
IP=$(cat tempFile | grep PublicIpAddress | awk '{ print $2 }' | sed s/\"//g | sed s/\,//g)

rm tempTest

ssh-add $SSH_KEY

#Install nginx and make sure that the default site listens on port 80
ssh -o StrictHostKeyChecking=no -l ubuntu $IP "sudo apt-get update; sudo apt-get install nginx\
                                               && sudo sed -i -e 's/listen [0-9]* default_server/listen 80 default_server/g' /etc/nginx/sites-enabled/default\
                                               && sudo sed -i -e 's/listen \[::\]:[0-9]* default_server ipv6only=on;/listen \[::\]:80 default_server ipv6only=on;/g' /etc/nginx/sites-enabled/default\
                                               && sudo service nginx restart"

#Get the ip on screen to check if nginx default site is running
echo "Type this ip into the browser to check your Nginx default site: $IP"
