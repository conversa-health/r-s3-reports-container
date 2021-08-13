# R S3 Reports container
This container is a simple wrapper of the `rocker/verse` container with a workflow to copy sources from an S3 bucket and copy output to an S3 bucket utilizing the `aws cli`.

The aws cli s3 commands don't explicitly set credentials, expecting that they are running under an IAM execution role in an AWS environment.
