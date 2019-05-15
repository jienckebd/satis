#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

$(aws ecr get-login --no-include-email --region us-east-1)

cd "${dir}/../" &&
docker build -t satis . &&
docker tag satis:latest 433059361193.dkr.ecr.us-east-1.amazonaws.com/satis:latest &&
docker push 433059361193.dkr.ecr.us-east-1.amazonaws.com/satis:latest
cd -
