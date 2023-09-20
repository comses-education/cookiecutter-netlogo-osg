# model configuration metadata used by the Makefile
#
# username to connect to OSG
OSG_USERNAME={{ cookiecutter.osg_username }}
# a short name of this computational model, used as the namespace
# for apptainer, Docker, and as a folder to keep things
# organized on the OSG filesystem login node.
#
# We recommend that you use all lowercase alphanumeric 
# with - or _ characters to separate words, e.g., 
# chime-abm, spatial-rust-model, black-hole-chaos-simulator
# replace with the name of your computational model. No spaces
MODEL_NAME="{{ cookiecutter.model_slug }}"
# replace with your main NetLogo entrypoint file.
MODEL_FILE={{ cookiecutter.model_file }}
# single behavior space experiment to run
# for multiple behavior space experiments, use a queue directive like
# `queue experiment from experiments.txt`
# where `experiments.txt` is a textfile with 
# one behavior space experiment per line
BEHAVIOR_SPACE_EXPERIMENT={{ cookiecutter.behavior_space_experiment }}
ENTRYPOINT_SCRIPT={{ cookiecutter.entrypoint_script }}
# the submit file to be executed on OSG via `condor_submit ${OSG_SUBMIT_FILE}`
OSG_SUBMIT_FILENAME="{{ cookiecutter.model_slug }}.sub"
# Condor submit script's queue directive
#
# for multiple behavior space experiments, use a queue directive like
# OSG_QUEUE_DIRECTIVE="experiment from experiments.txt"
OSG_QUEUE_DIRECTIVE="{{ cookiecutter.osg_queue_directive }}"
