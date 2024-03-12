INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
CURRENT_TAG=$(aws ec2 --region eu-west-1 describe-tags | grep Value | awk {'print $2'})
aws ec2 create-tags --resources ${INSTANCE_ID} --tags Key=Name,Value=${CURRENT_TAG}_${INSTANCE_ID}