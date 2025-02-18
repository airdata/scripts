for region in `aws ec2 describe-regions --output text | cut -f3`
do
     echo -e "\nListing Instances in region:'$region'..."
	aws ec2 describe-instances $region --query 'Reservations[].Instances[].Tags[?Key==`Name`].Value' --output text
done

