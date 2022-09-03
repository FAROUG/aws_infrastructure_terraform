#!/bin/bash
sudo yum update -y
sudo yum install git -y


### MySQL client installation
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
sudo yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo yum install -y mysql-community-client

# Mongo DB client Installation
sudo wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
echo -e "[mongodb-org-3.6] \nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/3.6/x86_64/\ngpgcheck=1 \nenabled=1 \ngpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc" | sudo tee /etc/yum.repos.d/mongodb-org-3.6.repo
sudo yum install -y mongodb-org-shell


echo "Pulling meta data for instance"
#INSTANCE_ID=`wget -qO- http://instance-data/latest/meta-data/instance-id`
INSTANCE_ID=`curl -X GET http://169.254.169.254/latest/meta-data/instance-id`
EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
REGION="`echo \"$EC2_AVAIL_ZONE\" | sed 's/[a-z]$//'`"
#REGION=`wget -qO- http://instance-data/latest/meta-data/placement/availability-zone | sed 's/.$//'`
aws ec2 describe-tags --region $REGION --filter "Name=resource-id,Values=$INSTANCE_ID" --output=text | grep -v 'aws:' | sed -r 's/TAGS\t(.*)\t.*\t.*\t(.*)/\1="\2"/' > /etc/ec2-tags
echo "INSTANCE_ID=${INSTANCE_ID}" >> /etc/ec2-tags
echo "REGION=${REGION}" >> /etc/ec2-tags
. /etc/ec2-tags
# echo "S3_BUCKET=${S3_BUCKET}" >> /etc/ec2-tags
# sudo aws s3 sync s3://${S3_BUCKET}/${AWS_SSH_ZIP_FILE_NAME}/ ~/.ssh/
aws s3api get-object --bucket ${S3_BUCKET} --key ${AWS_SSH_ZIP_FILE_NAME} ~/.ssh/${AWS_SSH_ZIP_FILE_NAME} 
# cp id_rsa /root/.ssh/id_rsa && chmod 600 $_  && chown -R ec2-user:ec2-user  $_
cd /root/.ssh && sudo unzip ~/.ssh/${AWS_SSH_ZIP_FILE_NAME} #~/.ssh/${AWS_SSH_ZIP_FILE_NAME} 
# && rm -rfv $_ 
chmod 600 ~/.ssh/id_rsa*  #&& chown -R ec2-user:ec2-user  $_
### Automated ssh-keygen without passphrase
## if the ~/.ssh/id_rsa file already exists, the command will exit without modifying anything.
## If not, you get a brand new key, in that filename.
# < /dev/zero ssh-keygen -q -N "" 
ssh-keyscan bitbucket.org >> ~/.ssh/known_hosts
mkdir -p /home/git/init
git clone ${repository} /home/git/init
cd /home/git/init
git checkout ${branch}
git reset --hard
SCRIPT="init-${app:-server}.sh"
/bin/bash $SCRIPT