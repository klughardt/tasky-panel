#!/bin/bash
set -eo pipefail

# Run Prowler with specific checks relevant to the Wiz exercise
docker run -ti --rm \
  -v $HOME/.aws:/root/.aws \
  prowlercloud/prowler:latest \
  -M json html \
  -f eu-central-1 \
  -g check16,check23,extra79,check43,check126 \
  -F prowler-scan-results

# Upload results to S3
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
aws s3 cp prowler-scan-results.json s3://wiz-security-scans-${AWS_ACCOUNT_ID}/prowler-$(date +%Y%m%d-%H%M%S).json
aws s3 cp prowler-scan-results.html s3://wiz-security-scans-${AWS_ACCOUNT_ID}/prowler-$(date +%Y%m%d-%H%M%S).html

# Analyze results
echo "Security Findings Summary:"
jq '.results | map(select(.status == "FAIL")) | group_by(.group) | map({group: .[0].group, count: length})' prowler-scan-results.json

# Exit with error code if critical findings found
if [ $(jq '[.results[] | select(.status == "FAIL" and .severity == "critical")] | length' prowler-scan-results.json) -gt 0 ]; then
  echo "Critical security findings detected!"
  exit 1
fi