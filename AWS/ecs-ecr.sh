#!/usr/bin/env bash
#
# DESCRIPTION: ECS Deployment Script
# MAINTAINER: Justin Kulesza = 4.4.12), python (~> 2.7.13), awscli (~> 1.11.91), docker-ce (>= 17.03.1)
#

set -e

# BEGIN CUSTOMIZATIONS #
ECS_REGION='us-west-2'
ECS_CLUSTER_NAME='name-of-ecs-cluster'
ECS_SERVICE_NAME='NameOfService'
ECS_TASK_DEFINITION_NAME='NameOfTaskDefinition'
ECR_NAME='name-of-ecr'
ECR_URI='account-number.dkr.ecr.us-west-2.amazonaws.com'
VERSION=$(date +%s)
AWSCLI_VER_TAR=1.11.91
# END CUSTOMIZATIONS #

# BEGIN OTHER VAR DEFINITIONS #
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ORIGINAL_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
ENVIRONMENT=""
BRANCH=""
AWSCLI_VER=$(aws --version 2>&1 | cut -d ' ' -f 1 | cut -d '/' -f 2)
# END OTHER VAR DEFINITIONS #

if [[ ${AWSCLI_VER} < ${AWSCLI_VER_TAR} ]]
then echo "ERROR: Please upgrade your AWS CLI to version ${AWSCLI_VER_TAR} or later!"
  exit 1
fi

usage() {
  echo "Usage: $0 -e  [-b ]"
  echo "  must be either 'staging' or 'production'"
  echo "  must be a valid ref. If no branch is provided, you will be prompted for one."
  exit 1
}

while getopts ":e:b:h" o; do
    case "${o}" in
        e)
            ENVIRONMENT=${OPTARG}
            (("${ENVIRONMENT}" == "staging" || "${ENVIRONMENT}" == "production")) || usage
            ;;
        b)
            BRANCH=${OPTARG}
            git rev-parse --abbrev-ref "${BRANCH}" || usage
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [[ -z "${ENVIRONMENT}" ]] ; then
    usage
fi

if [[ -z "${BRANCH}" ]] ; then
  echo -n "Which branch to deploy from [$(git rev-parse --abbrev-ref HEAD)] ? "
  read -r line
  if [[ -z "${line}" ]]; then
    BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  else
    git rev-parse --abbrev-ref "${line}" || exit 1
    BRANCH="${line}"
  fi
fi

(
  cd "${DIR}/.."
  git fetch --all
  git checkout "${BRANCH}"
)

(
  cd "${DIR}/.."
  docker build --pull -t "${ECR_NAME}:latest" -f ./docker/Dockerfile .
  docker tag "${ECR_NAME}:latest" "${ECR_URI}/${ECR_NAME}:${ENVIRONMENT}-${VERSION}"
  docker tag "${ECR_NAME}:latest" "${ECR_URI}/${ECR_NAME}:latest-${ENVIRONMENT}"
  $(aws ecr get-login --region "${ECS_REGION}")
  docker push "${ECR_URI}/${ECR_NAME}:${ENVIRONMENT}-${VERSION}"
  docker push "${ECR_URI}/${ECR_NAME}:latest-${ENVIRONMENT}"
)

(
  cd "${DIR}/.."
  REVISION=$(git rev-parse "${BRANCH}")
  PREVIOUS_TASK_DEF=$(aws ecs describe-task-definition --region "${ECS_REGION}" --task-definition "${ECS_TASK_DEFINITION_NAME}-${ENVIRONMENT}")
  NEW_CONTAINER_DEF=$(echo "${PREVIOUS_TASK_DEF}" | python <(cat <<-EOF
import sys, json
definition = json.load(sys.stdin)['taskDefinition']['containerDefinitions']
definition[0]['environment'].extend([
  {
    'name' : 'REVISION',
    'value' : '${REVISION}'
  },
  {
    'name' : 'RELEASE_VERSION',
    'value' : '${VERSION}'
  },
  {
    'name' : 'ENVIRONMENT',
    'value' : '${ENVIRONMENT}'
  }])
definition[0]['image'] = '${ECR_URI}/${ECR_NAME}:${ENVIRONMENT}-${VERSION}'
print json.dumps(definition)
EOF
  ))
  aws ecs register-task-definition --region "${ECS_REGION}" --family "${ECS_TASK_DEFINITION_NAME}-${ENVIRONMENT}" --container-definitions "${NEW_CONTAINER_DEF}"
  aws ecs update-service --region "${ECS_REGION}" --cluster "${ECS_CLUSTER_NAME}" --service "${ECS_SERVICE_NAME}-${ENVIRONMENT}"  --task-definition "${ECS_TASK_DEFINITION_NAME}-${ENVIRONMENT}"
)

(
  cd "${DIR}/.."
  git checkout "${ORIGINAL_BRANCH}"
)