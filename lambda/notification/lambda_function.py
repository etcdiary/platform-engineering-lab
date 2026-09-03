import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    logger.info("Received event: %s", json.dumps(event))

    response = {
        "status": "accepted",
        "message": "Notification request received",
        "request_id": context.aws_request_id,
    }

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(response),
    }