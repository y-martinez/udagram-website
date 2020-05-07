# Deploy a high-availability web app using CloudFormation
## Problem

Your company is creating an Instagram clone called Udagram. Developers pushed the latest version of their code in a zip file located in a public S3 Bucket.

You have been tasked with deploying the application, along with the necessary supporting software into its matching infrastructure.

This needs to be done in an automated fashion so that the infrastructure can be discarded as soon as the testing team finishes their tests and gathers their results.

## Project Requirements

> #### The Basics

|CRITERIA|MEETS SPECIFICATIONS|COMPLETED|GRADED|
|---|---|---|---|
|Parameters| The more the better, but an exaggerated number of parameters can be messy ( say, 10 or more ). 1 or 0 is definitely lacking.| :heavy_check_mark:| Approved  :blush: :+1: |
|Resources|This is the mandatory section of the script, we are looking for a LoadBalancer, Launch Configuration, AutoScaling group a health check, security groups and a Listener and Target Group.|:heavy_check_mark:| Approved  :blush: :+1: |
|Outputs|This is optional, but it would be nice to have a URL here with the Load Balancer DNS Name and “http” in front of it .|:heavy_check_mark:| Approved  :blush: :+1: |
|Working Test|If the student provides a URL to verify his work is running properly, it will be a page that says “it works! Udagram, Udacity”|:heavy_check_mark:| Approved  :blush: :+1: |

> #### Load Balancer

|CRITERIA|MEETS SPECIFICATIONS|COMPLETED|GRADED|
|---|---|---|---|
|Target Group|The auto-scaling group needs to have a property that associates it with a target group. The Load Balancer will have a Listener rule associated with the same target group|:heavy_check_mark:| Approved  :blush: :+1: |
|Health Check and Listener|Port 80 should be used in Security groups, health checks and listeners associated with the load balancer|:heavy_check_mark:| Approved  :blush: :+1: |

> #### Auto-Scaling

|CRITERIA|MEETS SPECIFICATIONS|COMPLETED|GRADED|
|---|---|---|---|
|Subnets|Students should be using PRIV-NET ( private subnets ) for their auto-scaling instances|:heavy_check_mark:| Approved  :blush: :+1: |
|Machine Specs|The machine should have 10 GB or more of disk and should be a t3.small or better.|:heavy_check_mark:| Approved  :blush: :+1: |
|SSH Key|There shouldn’t be a ‘keyname’ property in the launch config|:heavy_check_mark:| Approved  :blush: :+1: |

> #### Bonus

|CRITERIA|MEETS SPECIFICATIONS|COMPLETED|GRADED|
|---|---|---|---|
|Output|Any values in the output section are a bonus|:heavy_check_mark:| Approved  :blush: :+1: |
|Bastion Host|Any resource of type `AWS::EC2::Instance`, optional, but nice to have.|:heavy_check_mark:| Approved  :blush: :+1: |

### Other considerations


## Solution

> ### Diagram

![Diagram](/docs/Project_2_Udacity_CDE_nanodegree.png)

> ### Description

The solution consisted in split the whole infrastructure in differents stack template files this allow that the project has modularity.

> ### Files structure
1. The `network` folder has the files to deploy a stack with the whole network to the will using in the project.
2. The `bastion` folder has the files to deploy a stack with a bastion host to connect the hosts with the website of a secure way.
3. The `bucket` folder has the files to deploy a stack with the `AWS::S3` bucket that stores the website files, that is, `Udacity.zip`
4. The `iam` folder has the files to deploy a stack with the role that will use to upload/download files from the bucket
5. The `server` folder has the files to deploy a stack with the website hosts. Also deploy these hosts using `LoadBalancer`, `AutoScaling`, and `ClouWatch` alarms.
6. The `src` folder has the website files to deploy.
7. The `utils` folder has the code files using to help such as utilities.

> ### Instructions

This is a project that anyone could uses to learn about CloudFormation, if you want to deploy this project follow the instructions are below:

1. You need to create a Secure KeyPair that will use to connect to Bastion Host, in a terminal using the file `utils/create-secure-key.sh`
    > `utils/create-secure-key.sh`

2. You need to create the website files to upload to S3 Bucket, in a terminal using the command zip, 
    > `zip udacity.zip src/*`

3. You need to create the s3 and iam stacks, in a terminal using the file `utils/create-stack-key.sh` 
    > `utils/create-stack.sh iam-stack iam/iam-stack-template.yml iam/iam-parameters.json`
    
    > `utils/create-stack.sh s3-stack bucket/s3-bucket-stack-template.yml bucket/s3-bucket-parameters.json`

4. You need to upload the website files created previously to s3 bucket, in a terminal using aws cli
    > `aws s3 cp udacity.zip s3://udagram-s3-store`

5. You need to create the other stacks described above, in a terminal

    > `utils/create-stack.sh network-stack network/network-stack-template.yml network/network-parameters.json`
    
    > `utils/create-stack.sh bastion-stack bastion/bastion-stack-template.yml bastion/bastion-parameters.json`

    > `utils/create-stack.sh server-stack server/server-stack-template.yml server/server-parameters.json`

You can access to the final website using this LoadBalancer [link](http://serve-WebAp-1XZJSYM9JEABE-1266606802.us-west-2.elb.amazonaws.com)
