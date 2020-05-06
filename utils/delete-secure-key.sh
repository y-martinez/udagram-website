aws ec2 delete-key-pair --key-name "udagramBastionKey"
aws ssm delete-parameter --name 'udagramBastionKey'
aws ssm delete-parameter --name 'udagramBastionKeyPrivate'
rm ~/.ssh/udagramBastionKey*