#!/usr/bin/env bash
set -e

BUILD_TAG=${1:-'build'}
TEST_IMAGE=rest_api_tests:${BUILD_TAG}

docker build -t ${TEST_IMAGE} --build-arg BUILDTAG=${BUILD_TAG} -f rest_api/Dockerfile_tests .

#echo "Pylint tests>>>"
#docker run -i --rm ${TEST_IMAGE} bash -c \
#    "pylint --rcfile=rest_api/.pylintrc --fail-under=8 ./rest_api"
#echo "<<Pylint tests"

echo "Unit tests>>>"
docker run -i --rm ${TEST_IMAGE} \
    bash -c "python3 -m unittest discover ./rest_api/rest_api_server/tests"
echo "<<Unit tests"

#echo "Pycodestyle tests>>>"
#docker run -i --rm ${TEST_IMAGE} \
#    bash -c "pycodestyle --max-line-length=2000 rest_api"
#echo "<<<Pycodestyle tests"

docker rmi ${TEST_IMAGE}
