import json
import os
import boto3

ses = boto3.client("ses")

SENDER = os.environ["SENDER_EMAIL"]
RECIPIENT = os.environ["RECIPIENT_EMAIL"]


def lambda_handler(event, context):
    for record in event["Records"]:
        body = json.loads(record["body"])
        detail = body.get("detail", {})

        ses.send_email(
            Source=SENDER,
            Destination={"ToAddresses": [RECIPIENT]},
            Message={
                "Subject": {"Data": "Platform Notification"},
                "Body": {
                    "Text": {"Data": f"Notification received:\n\n{json.dumps(detail, indent=2)}"}
                },
            },
        )

    return {"statusCode": 200}