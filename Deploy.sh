#!/bin/bash

set -e

echo " Starting Deployment..."


cd terraform

echo " Initializing Terraform..."
terraform init

echo " Applying Terraform..."
terraform apply -auto-approve

echo " Fetching EC2 IP..."
EC2_IP=$(terraform output -raw ec2_public_ip)

echo " EC2 IP: $EC2_IP"

cd ..


echo " Waiting for EC2 to be ready..."

while ! nc -z $EC2_IP 22; do
  echo "Waiting for SSH..."
  sleep 5
done

echo " EC2 is ready!"


echo " Creating inventory..."

cat <<EOL > ansible/inventory.ini
[web]
$EC2_IP ansible_user=ubuntu ansible_ssh_private_key_file=$(pwd)/ansible-key.pem
EOL

chmod 400 ansible-key.pem


echo " Running Ansible..."

ansible-playbook -i ansible/inventory.ini ansible/nginx-setup.yml

echo " Deployment Completed!"