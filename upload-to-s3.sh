#!/bin/bash

# This script helps you upload your CloudFormation template to S3 and make it publicly accessible

# Set your S3 bucket name
echo "Enter your S3 bucket name:"
read S3_BUCKET

# Check if bucket exists, if not create it
if ! aws s3 ls "s3://$S3_BUCKET" 2>&1 | grep -q 'NoSuchBucket'; then
    echo "Bucket exists, continuing..."
else
    echo "Bucket does not exist, creating..."
    aws s3 mb "s3://$S3_BUCKET"
    
    # Set bucket policy to allow public read access
    cat > /tmp/bucket-policy.json << EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::$S3_BUCKET/*"
        }
    ]
}
EOF
    
    aws s3api put-bucket-policy --bucket "$S3_BUCKET" --policy file:///tmp/bucket-policy.json
fi

# Upload CloudFormation template to S3
echo "Uploading CloudFormation template to S3..."
aws s3 cp domestic_inclusive_violance_demo.yaml "s3://$S3_BUCKET/"

# Make the template publicly accessible
aws s3api put-object-acl --bucket "$S3_BUCKET" --key domestic_inclusive_violance_demo.yaml --acl public-read

# Update README.md with the correct S3 bucket name
echo "Updating README.md with S3 bucket name..."
sed -i.bak "s/YOUR-S3-BUCKET/$S3_BUCKET/g" README.md
rm -f README.md.bak

echo ""
echo "Template uploaded successfully to: https://$S3_BUCKET.s3.amazonaws.com/domestic_inclusive_violance_demo.yaml"
echo "README.md has been updated with the correct S3 bucket name."
echo ""
echo "Next steps:"
echo "1. Commit and push the updated README to GitHub:"
echo "   git add README.md"
echo "   git commit -m \"Update README with S3 bucket name\""
echo "   git push"
