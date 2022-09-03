resource "aws_iam_policy" "AWS_IAM_POLICY_EC2_CUSTOMIZED" {
  name = "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_IAM_POLICY_EC2_CUSTOMIZED_NAME}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      #   {
      #     Action   = ["s3:ListAllMyBuckets", "s3:ListBucket", "s3:HeadBucket"]
      #     Effect   = "Allow"
      #     Resource = "*"
      #   },
      ## AmazonSQSFullAccess
      {
        "Effect" : "Allow",
        "Action" : [
          "sqs:*"
        ],
        "Resource" : "*"
      },
      ## CloudWatchAgentAdminPolicy
      {
        "Effect" : "Allow",
        "Action" : [
          "cloudwatch:PutMetricData",
          "ec2:DescribeTags",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups",
          "logs:CreateLogStream",
          "logs:CreateLogGroup"
        ],
        "Resource" : "*"
      },
      ## AmazonS3FullAccess
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetParameter",
          "ssm:PutParameter"
        ],
        "Resource" : "arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*",
          "s3-object-lambda:*"
        ],
        "Resource" : "*"
      },
      ## AWSCodeDeployFullAccess
      {
        "Action" : "codedeploy:*",
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Sid" : "CodeStarNotificationsReadWriteAccess",
        "Effect" : "Allow",
        "Action" : [
          "codestar-notifications:CreateNotificationRule",
          "codestar-notifications:DescribeNotificationRule",
          "codestar-notifications:UpdateNotificationRule",
          "codestar-notifications:DeleteNotificationRule",
          "codestar-notifications:Subscribe",
          "codestar-notifications:Unsubscribe"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "codestar-notifications:NotificationsForResource" : "arn:aws:codedeploy:*"
          }
        }
      },
      {
        "Sid" : "CodeStarNotificationsListAccess",
        "Effect" : "Allow",
        "Action" : [
          "codestar-notifications:ListNotificationRules",
          "codestar-notifications:ListTargets",
          "codestar-notifications:ListTagsforResource",
          "codestar-notifications:ListEventTypes"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "CodeStarNotificationsSNSTopicCreateAccess",
        "Effect" : "Allow",
        "Action" : [
          "sns:CreateTopic",
          "sns:SetTopicAttributes"
        ],
        "Resource" : "arn:aws:sns:*:*:codestar-notifications*"
      },
      {
        "Sid" : "CodeStarNotificationsChatbotAccess",
        "Effect" : "Allow",
        "Action" : [
          "chatbot:DescribeSlackChannelConfigurations"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "SNSTopicListAccess",
        "Effect" : "Allow",
        "Action" : [
          "sns:ListTopics"
        ],
        "Resource" : "*"
      },
      ## AmazonSSMManagedInstanceCore
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:DescribeAssociation",
          "ssm:GetDeployablePatchSnapshotForInstance",
          "ssm:GetDocument",
          "ssm:DescribeDocument",
          "ssm:GetManifest",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:ListAssociations",
          "ssm:ListInstanceAssociations",
          "ssm:PutInventory",
          "ssm:PutComplianceItems",
          "ssm:PutConfigurePackageResult",
          "ssm:UpdateAssociationStatus",
          "ssm:UpdateInstanceAssociationStatus",
          "ssm:UpdateInstanceInformation"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2messages:AcknowledgeMessage",
          "ec2messages:DeleteMessage",
          "ec2messages:FailMessage",
          "ec2messages:GetEndpoint",
          "ec2messages:GetMessages",
          "ec2messages:SendReply"
        ],
        "Resource" : "*"
      },
      ## AmazonSNSFullAccess
      {
        "Action" : [
          "sns:*"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}
