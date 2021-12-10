import boto3


def create_topic(topic_name: str):
    """Creating topic using boto3-sns"""
    print("starting....")
    client = boto3.client("sns")
    try:
        response = client.create_topic(
            Name=topic_name,
        )
        print("done")
        print(response)
        return response['TopicArn']
    except Exception:
        print("AN error occurred!")


def subscribe(topic_name: str, protocol: str, endpoint: str):
    """creating topic's subscription"""
    print("strart")
    client = boto3.client("sns")
    try:
        response = client.subscribe(
            TopicArn=create_topic(topic_name),
            Protocol=protocol,
            Endpoint=endpoint,
            ReturnSubscriptionArn=True
        )
        print(response)
        print("done")
        return response
    except Exception:
        print("AN error occurred!")


def confirm_subscription():
    pass


subscribe("hoan-sns-python-test", "email", "16520430@gm.uit.edu.vn")
