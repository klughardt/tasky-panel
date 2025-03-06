/*
resource "aws_cloudwatch_metric_alarm" "public_bucket_access" {
  alarm_name          = "PublicBucketAccess"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "NumberOfObjects"
  namespace           = "AWS/S3"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_actions       = [aws_sns_topic.security_alerts.arn]
}

resource "aws_guardduty_detector" "main" {
  enable = true
}

resource "aws_sns_topic" "security_alerts" {
  name = "wiz-security-alerts"
}
*/