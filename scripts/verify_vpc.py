import boto3

# Connect to your LocalStack container
ec2 = boto3.client(
    'ec2', 
    endpoint_url='http://localhost:4566',
    region_name='us-east-1',
    aws_access_key_id='test',
    aws_secret_access_key='test'
)

def check_vpcs():
    vpcs = ec2.describe_vpcs()
    for vpc in vpcs['Vpcs']:
        print(f"CloudWire VPC Found: {vpc['VpcId']} | State: {vpc['State']}")

if __name__ == "__main__":
    check_vpcs()
