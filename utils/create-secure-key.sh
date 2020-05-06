ssh-keygen -t rsa -b 4096 -f ~/.ssh/udagramBastionKey -C "Udagram bastion key" -N '' -q

aws ec2 import-key-pair --key-name "udagramBastionKey" --public-key-material fileb://~/.ssh/udagramBastionKey.pub
aws ssm put-parameter --name 'udagramBastionKeyPrivate' --value "$(cat ~/.ssh/udagramBastionKey)" --type SecureString --overwrite
aws ssm put-parameter --name 'udagramBastionKey' --value "$(cat ~/.ssh/udagramBastionKey.pub)" --type SecureString --overwrite