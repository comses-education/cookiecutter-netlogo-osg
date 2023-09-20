#!/usr/bin/env bash

# USAGE: ./run.sh behavior_space_experiment_name

CODE_DIR="${MODEL_CODE_DIR:-/srv}"
NETLOGO_FILE="${1:-{{ cookiecutter.model_file }}}"
EXPERIMENT="${2:-{{ cookiecutter.behavior_space_experiment }}}"
BEHAVIOR_SPACE_EXPERIMENTS_SETUP_FILE=${2:-none}

# FIXME: this should be configurable
JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS:--Xmx4G}"

echo "Running NetLogo headless on ${CODE_DIR}/${NETLOGO_FILE} with experiment ${EXPERIMENT}"

export JAVA_TOOL_OPTIONS

/opt/netlogo/netlogo-headless.sh \
  --model ${CODE_DIR}/${NETLOGO_FILE} \
  --experiment ${EXPERIMENT} \
  --table ${CODE_DIR}/${EXPERIMENT}.csv
