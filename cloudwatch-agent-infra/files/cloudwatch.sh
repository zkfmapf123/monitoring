#!/bin/bash

sudo yum update -y
sudo yum install -y amazon-ssm-agent

sudo systemctl start amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent

# sudo systemctl status amazon-ssm-agent

## Install Cloudwatch-agent
curl -O https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo yum install -y ./amazon-cloudwatch-agent.rpm

## Start wizard
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard

## sudo systemctl status amazon-cloudwatch-agent
