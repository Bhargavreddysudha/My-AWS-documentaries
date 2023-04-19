#!/bin/bash

#get the region and zone name
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')
ZONE=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Get Ec2 instance type
INSTANCE_TYPE=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-type)

# Create the index.html file
cat > /var/www/html/index.html << EOF
<html>
<head>
  <title>Instance Metadata</title>
</head>
<body>
  <h1>Instance Metadata</h1>
  <ul>
    <li><b>Zone:</b> ${ZONE}</li>
    <li><b>Region:</b> ${REGION}</li>
    <li><b>Instance Type:</b> ${INSTANCE_TYPE}</li>
  </ul>
</body>
</html>
EOF
