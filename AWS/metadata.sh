#!/bin/bash
# JQ is required to more easily parse json.
AWS_IAM_ROLE=`curl -sL http://169.254.169.254/latest/meta-data/iam/security-credentials/`
AWS_ACCESS_KEY_ID=`curl -sL http://169.254.169.254/latest/meta-data/iam/security-credentials/$AWS_IAM_ROLE/ | jq -r '.AccessKeyId'`
AWS_SECRET_ACCESS_KEY=`curl -sL http://169.254.169.254/latest/meta-data/iam/security-credentials/$AWS_IAM_ROLE/ | jq -r '.SecretAccessKey'`
AWS_TOKEN=`curl -sL http://169.254.169.254/latest/meta-data/iam/security-credentials/$AWS_IAM_ROLE/ | jq -r '.Token'`
AWS_AZ=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
AWS_DEFAULT_REGION="`echo \"$AWS_AZ\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
LOCAL_IP=`curl -sL http://169.254.169.254/latest/meta-data/local-ipv4`
PUBLIC_IP=`curl -sL http://169.254.169.254/latest/meta-data/public-ipv4`

