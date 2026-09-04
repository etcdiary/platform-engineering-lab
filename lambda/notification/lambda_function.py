import json
import logging
import os
import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

events = boto3.client("events")

EVENT_BUS_NAME = os.environ["EVENT_BUS_NAME"]


def lambda_handler(event, context):
    logger.info("Received event: %s", json.dumps(event))

    events.put_events(
        Entries=[
            {
                "Source": "platform.notification",
                "DetailType": "NotificationRequested",
                "Detail": json.dumps({"request_id": context.aws_request_id}),
                "EventBusName": EVENT_BUS_NAME,
            }
        ]
    )

    response = {
        "status": "accepted",
        "message": "Notification request received",
        "request_id": context.aws_request_id,
    }

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(response),
    }