#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-01bc7ebe005fb1cb2" # replace with your SG ID
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z032558618100M4EJX8X4" # replace with your ZONE ID
DOMAIN_NAME="daws84s.site" # replace with your domain

for instance in ${INSTANCES[@]}
#for instance in $@
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-0220d79f3f480ecf5 --instance-type t3.micro --security-group-ids sg-08919aeecf4b1e545 --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=$instance}]" --query "Instances[0].InstanceId" --output text)
    echo "INSTANCE_ID=$INSTANCE_ID"
    if [ $instance != "frontend" ]
    then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
        
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    fi
    echo " IP of $instance is $IP "
done
