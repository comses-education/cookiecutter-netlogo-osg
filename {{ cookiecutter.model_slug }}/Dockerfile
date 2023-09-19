FROM comses/netlogo:6.3.0

ENV MODEL_CODE_DIR=/code/src
ARG MODEL_FILE={{ cookiecutter.model_file }}
ARG BEHAVIOR_SPACE_EXPERIMENT={{ cookiecutter.behavior_space_experiment }}

WORKDIR /code
COPY . /code

CMD ["/code/scripts/run.sh", "${MODEL_FILE}", "${BEHAVIOR_SPACE_EXPERIMENT}"]
