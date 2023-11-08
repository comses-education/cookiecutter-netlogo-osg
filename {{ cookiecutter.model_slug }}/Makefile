include config.mk

# user to connect to OSG as, defaults to local username
OSG_USERNAME ?= ${USER}
OSG_SUBMIT_NODE ?= osg
OSG_OSDF_PATH ?= /ospool/protected/${OSG_USERNAME}
# name of this computational model
MODEL_NAME ?= my-netlogo-model
BEHAVIOR_SPACE_EXPERIMENT ?= osg_experiment
MODEL_SRC_DIRECTORY ?= src
MODEL_FILE ?= "${MODEL_NAME}.nlogo"
MODEL_FILE_PATH = ${MODEL_SRC_DIRECTORY}/${MODEL_FILE}
# entrypoint script to be called by job-wrapper.sh
ENTRYPOINT_SCRIPT ?= run.sh
# the OSG output file to be transferred
OUTPUT_FILES ?= output.csv
# OSG submit template
# all generated outputs to be placed on OSG live here
BUILD_DIR ?= osg-build
# the submit file to be executed on OSG via `condor_submit ${OSG_SUBMIT_FILE}`
OSG_SUBMIT_TEMPLATE = scripts/submit.template
OSG_SUBMIT_FILENAME = ${BUILD_DIR}/${MODEL_NAME}.sub
OSG_QUEUE_DIRECTIVE ?= 5

CONTAINER_DEF ?= container.def
CURRENT_VERSION ?= v1
DOCKER_IMAGE_NAME ?= comses/${MODEL_NAME}:${CURRENT_VERSION}
APPTAINER_IMAGE_NAME ?= ${MODEL_NAME}-${CURRENT_VERSION}.sif

.PHONY: clean deploy apptainer-build docker-build docker-run

all: build

apptainer-build: $(CONTAINER_DEF)
	apptainer build --fakeroot ${APPTAINER_IMAGE_NAME} ${CONTAINER_DEF}

$(OSG_SUBMIT_FILENAME): $(OSG_SUBMIT_TEMPLATE) config.mk
	mkdir -p ${BUILD_DIR}
	APPTAINER_IMAGE_NAME=${APPTAINER_IMAGE_NAME} \
	OSG_USERNAME=${OSG_USERNAME} \
	BEHAVIOR_SPACE_EXPERIMENT=${BEHAVIOR_SPACE_EXPERIMENT} \
	MODEL_NAME=${MODEL_NAME} \
	MODEL_FILE=${MODEL_FILE} \
	MODEL_FILE_PATH=${MODEL_FILE_PATH} \
	ENTRYPOINT_SCRIPT=${ENTRYPOINT_SCRIPT} \
	OUTPUT_FILES=${OUTPUT_FILES} \
	JAVA_TOOL_OPTIONS=${JAVA_TOOL_OPTIONS} \
	QUEUE_DIRECTIVE=${OSG_QUEUE_DIRECTIVE} \
	envsubst < ${OSG_SUBMIT_TEMPLATE} > ${OSG_SUBMIT_FILENAME}

docker-build: $(OSG_SUBMIT_FILENAME) Dockerfile
	docker build -t "${DOCKER_IMAGE_NAME}" .

build: ${BUILD_DIR}

${BUILD_DIR}: $(OSG_SUBMIT_FILENAME)
	cp -r scripts/* ${BUILD_DIR}
	rsync -avP ${MODEL_SRC_DIRECTORY} ${BUILD_DIR}

clean:
	rm -rf ${BUILD_DIR} ${APPTAINER_IMAGE_NAME} ${OSG_SUBMIT_FILENAME} *~

deploy: build ${BUILD_DIR}
	echo "IMPORTANT: This command assumes you have created an ssh alias in your ~/.ssh/config named '${OSG_SUBMIT_NODE}' that connects to your OSG connect node"
	echo "Creating ${MODEL_NAME} folder in /home/${OSG_USERNAME}"
	ssh ${OSG_USERNAME}@${OSG_SUBMIT_NODE} "mkdir -p ${MODEL_NAME}"
	echo "Copying submit filename, job script, and entrypoint scripts to /home/${OSG_USERNAME}/${MODEL_NAME}"
	rsync -avzP ${BUILD_DIR}/ ${OSG_SUBMIT_NODE}:${MODEL_NAME}/

docker-run: docker-build
	docker run --rm -it "${DOCKER_IMAGE_NAME}" bash /code/scripts/run.sh "${MODEL_FILE_PATH}" "${BEHAVIOR_SPACE_EXPERIMENT}"
