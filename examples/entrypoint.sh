#!/bin/bash

COUNT_ATTEMPT=20

echo "Attempt to connect to the endpoint: $AWS_ENDPOINT in region $AWS_REGION"
for ((n=$COUNT_ATTEMPT;n>0;n--)) ; do
    aws s3 ls --endpoint $AWS_ENDPOINT --region $AWS_REGION > /dev/null
    if [[ $? == 0 ]] ; then
        break
    fi
    echo "Next connection attempt in 1s"
    sleep 1
done

[[ $n == 0 ]] && echo "Failed connection to endpoint: $AWS_ENDPOINT in region $AWS_REGION" && exit 1

echo "Successful connection to endpoint: $AWS_ENDPOINT in region $AWS_REGION"

echo "Run examples: fifo-queue"
sh ./examples/tf-plan-apply.sh "fifo"

echo "Run examples: standard-queue"
sh ./examples/tf-plan-apply.sh "standard_with_dlq"