## This would be a ECS cluster that would contain two services 

<p>Service 1 -> User can upload a file which would then be uploaded to an S3 bucket.
<br>Service 2 -> User can key in a message which would be input into a SQS Queue.

<p>Prerequistes: VPC with public subnets, 2x ECRs created beforehand.

<p>Step 1: Created the two services
<br>Step 2: Created ECS Cluster
<br>Step 3: Created S3 Bucket with ACL "public-read"

