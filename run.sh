#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

opts=(
  ansible-playbook          # must be first
  -i "${SCRIPT_DIR}/inventory/"
  --become
  "${SCRIPT_DIR}/site.yml"  # must be last
)

export ANSIBLE_CALLBACKS_ENABLED='timer,profile_tasks'
export ANSIBLE_STDOUT_CALLBACK='yaml'

export ANSIBLE_ROLES_PATH="${SCRIPT_DIR}/external/kubespray_senorsmile/roles/"
export ANSIBLE_LIBRARY="${SCRIPT_DIR}/external/kubespray_senorsmile/library/"

date
time pipenv run ${opts[@]} ${@}
date
