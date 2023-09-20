# {{ cookiecutter.project_name }}

{{ cookiecutter.model_short_description }}

## Detailed Model Documentation

<!-- FIXME: Please edit this section and replace each section text's guidance with the appropriate text -->

### Narrative Documentation

EDIT: Include narrative documentation in a durable text format (e.g., PDF with no special extensions, .odt OpenOffice Document file, Markdown .md or plaintext .txt files). This documentation should ideally enable a careful reader to replicate your computational model just based on its description and describe expected . Consider including visual diagrams and flowcharts and adhering to structured, domain-specific protocols like the [ODD Protocol for Describing Agent-Based and other Simulation Models](https://www.jasss.org/23/2/7.html) 

### Sensitivity Analyses and Uncertainty Quantification

EDIT: Include sensitivity analyses and uncertainty quantification as applicable

### Model reuse and extension

EDIT: If this model is designed to accommodate reuse and/or extension, please document extension points, future work, and
general guidance on how the model could be reused, extended, or adapted. If this model is not designed for reuse it may
be helpful to explicitly say so here.

## How to run this model

EDIT: replace this text with how this model should be run. Include interesting parameterizations, acceptable inputs, and
expected outputs.

### Containerization and Open Science Grid Scripts

In order to run this NetLogo model on the Open Science Grid we'll be using
[containerization](https://forum.comses.net/t/what-is-a-container-and-why-should-you-containerize-your-model/8139).

CoMSES Net has made recent versions of NetLogo available on the Open Science Grid and
[Docker Hub](https://hub.docker.com/r/comses/osg-netlogo)

### Running on the Open Science Grid

#### Set up your user account on the Open Science Grid 

The first step to getting your models to run on the Open Science Grid is to apply for a user account on the Open Science Grid.

https://osg-htc.org/research-facilitation/accounts-and-projects/general/index.html

You must have already gone through the OSG facilitation process with access to an Open Science Grid login node before
`% make deploy` will work.

Generating an SSH key creates two keys, a public key that you share with OSG, and a private key that you keep safe and secure on your local system. Keep track of the private SSH key you generated, you'll need the path to this key in the next step.

Create an alias in your `~.ssh/config` file that assigns the name `osg` to your OSG login node.

The rest of these instructions assume you are in an **interactive command-line shell or terminal application**. For more detailed information on how to navigate the command-line you may find the [Software Carpentries Shell lesson](https://swcarpentry.github.io/shell-novice/) useful. 

If you are running on macOS this means you will need a richer command line environment. We recommend [MacPorts](https://www.macports.org/install.php) but [Homebrew](https://brew.sh/) should also work. 

This will probably take some time to download / install.

Another problematic dependency is Apptainer / singularity which is how we deploy our code [using containerization](https://portal.osg-htc.org/documentation/htc_workloads/using_software/containers-docker/) to OSG. Alternatively you can see if an existing singularity image at  https://github.com/opensciencegrid/cvmfs-singularity-sync can be used to interpret / execute your model source code. This option may not be tenable for models with a lot of additional software / system dependencies though condaforge can help too.

**Currently Apptainer only runs on Linux natively**, and requires a Linux virtual machine to run on Windows or Mac:

https://apptainer.org/docs/admin/1.2/installation.html


``` bash
nano ~/.ssh/config
```

And add the following lines to it:

```
Host *
    UseKeychain yes
    AddKeysToAgent yes
    IdentityFile ~/.ssh/id_rsa

Host osg
    HostName ap40.uw.osg-htc.org # change this to your OSG login node
    User your-assigned-osg-username # change this to your OSG username
    IdentityFile ~/.ssh/your-osg-private-ssh-key # change this path to the private key that you generated whose public key counterpart you added to your OSG profile
```

At this point you should be able to run 

``` bash

$ ssh osg

```

The very first time you run this command you will probably see a warning pop up something like the following:

``` bash
The authenticity of host 'ap40.uw.osg-htc.org (<no hostip for proxy command>)' can't be established.
ED25519 key fingerprint is SHA256:7tERlznf+JS4Krh9KcL9lEzjrqznRltmwlhy5r0G1Bc.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? 
```

Type `yes` and hit return to cache the OSG login node's host key in your SSH client's `known_hosts`.

It takes some time for the SSH keys to propagate to the login node, so if you get an error like the following:

``` bash
$ ssh osg
your-username@ap40.uw.osg-htc.orgt: Permission denied (publickey,gssapi-keyex,gssapi-with-mic,hostbased).
```

Take a break, usually it's available in a few minutes, but the [official docs](https://portal.osg-htc.org/documentation/overview/account_setup/generate-add-sshkey/#step-2-add-the-public-ssh-key-to-login-node) state that it could take a couple of hours for your submitted public key to be synchronized with the login node.

[OSG docs on connecting to OSG and generating SSH keys](https://portal.osg-htc.org/documentation/overview/account_setup/generate-add-sshkey/)

#### Customize model metadata

The initial [cookiecutter](https://cookiecutter.readthedocs.io/en/stable/) or [cruft](https://cruft.github.io/cruft/)
templatization should have created an appropriate config.mk but you may still need to customize variables defined in
`config.mk`

```
# user to connect to OSG as
OSG_USERNAME=your_osg.username
# a short name of this computational model, used as the namespace (for apptainer, Docker, and as a folder to keep things
# organized on the OSG filesystem login node). Don't add spaces, and we recommend that you use all lowercase alphanumeric with - or _ to
# separate words, e.g., chime-abm, spatial-rust-model, black-hole-chaos-simulator.
# NOTE: whatever you choose as your model name carries the convention that your main .nlogo file entrypoint should also
be named your-model-name.nlogo, e.g., chime-abm.nlogo, spatial-rust-model.nlogo, black-hole-chaos-simulator.nlogo
MODEL_NAME= your-model-name
# the behavior space experiment to run. To run multiple experiments, see the queue experiment from experiments.txt section
BEHAVIOR_SPACE_EXPERIMENT=comses_osg_experiment  
ENTRYPOINT_SCRIPT= run.sh  # do not modify this unless you're doing something special
# the submit file to be executed on OSG via `condor_submit ${OSG_SUBMIT_FILE}`
OSG_SUBMIT_FILENAME= ${MODEL_NAME}.submit
OSG_QUEUE_DIRECTIVE=5  # the condor submit script's queue directive
```


### Customize your model's OSG execution style

The `scripts/run.sh` shell script provided in this template should work for most NetLogo model use cases. It takes two
command-line arguments in the following order: 

1. the name of the NetLogo model file to be run. This should be automatically taken care of if you follow the convention
   of placing your NetLogo `.nlogo` file in the `src/` directory and specify its basename in `config.mk`. For example,
   `MODEL_NAME=innovation-diffusion` assumes the existence of a `src/innovation-diffusion.nlogo` file.
2. a behavior space experiment name to be run. This should live in your `${MODEL_NAME}.nlogo` file, if you want to read
   behavior space experiments from a [separate file](https://ccl.northwestern.edu/netlogo/docs/behaviorspace.html#advanced-usage)
   you'll need to edit `run.sh` to include a `--setup-file` argument

There are currently two styles of OSG execution supported, described in more detail below.

#### queue experiment from experiments.txt

This style runs multiple named behavior space experiments listed with one behavior space experiment name per line in
`experiments.txt`. An example `experiments.txt` might look like this:

```
% cat experiments.txt
osg_irma_county_evac_output_no_factors
osg_irma_county_evac_output_over65
osg_irma_county_evac_output_under18
osg_irma_county_evac_output_no_vehicle
osg_irma_county_evac_output_food_stamps
```

1. Place this file in the `scripts` directory to be automatically included in the generated `osg-build` directory that
contains all your OSG job submission files.
2. Edit `config.mk` and set `OSG_QUEUE_DIRECTIVE="queue experiment from experiments.txt"`

Copy the OSG submission package to your OSG access point and submit the job. If the job completes successfully your
output files should live in the `outputs/` directory like this:

```
% pwd
/home/allen.lee/chime-abm
% ls -al outputs
total 1152
drwxrwxr-x 2 allen.lee allen.lee   4096 Aug 10 14:49 ./
drwxrwxr-x 5 allen.lee allen.lee   4096 Sep 13 20:26 ../
-rw-r--r-- 1 allen.lee allen.lee 233050 Aug 23 18:37 osg_irma_county_evac_output_food_stamps.output.csv
-rw-r--r-- 1 allen.lee allen.lee 233341 Aug 23 18:32 osg_irma_county_evac_output_no_factors.output.csv
-rw-r--r-- 1 allen.lee allen.lee 233231 Aug 23 18:35 osg_irma_county_evac_output_no_vehicle.output.csv
-rw-r--r-- 1 allen.lee allen.lee 232730 Aug 23 19:11 osg_irma_county_evac_output_over65.output.csv
-rw-r--r-- 1 allen.lee allen.lee 233826 Aug 23 19:10 osg_irma_county_evac_output_under18.output.csv
```

#### queue N

This basic OSG queue directive says "Run N copies of this model". Model output should be placed in your
outputs directory in a form like this (in this example, N = 5):

```
% ls -al outputs
total 428
drwxrwxr-x 2 allen.lee allen.lee  4096 Aug 23 23:41 ./
drwxrwxr-x 6 allen.lee allen.lee  4096 Aug 30 17:57 ../
-rw-rw-r-- 1 allen.lee allen.lee     0 Aug 19 17:58 .gitkeep
-rw-r--r-- 1 allen.lee allen.lee 82474 Aug 23 23:41 vary_food_gains_osg.0.csv
-rw-r--r-- 1 allen.lee allen.lee 82487 Aug 23 23:40 vary_food_gains_osg.1.csv
-rw-r--r-- 1 allen.lee allen.lee 82538 Aug 23 23:39 vary_food_gains_osg.2.csv
-rw-r--r-- 1 allen.lee allen.lee 82127 Aug 23 23:41 vary_food_gains_osg.3.csv
-rw-r--r-- 1 allen.lee allen.lee 82141 Aug 23 23:41 vary_food_gains_osg.4.csv
```

## Makefile targets

We've included a Makefile that should help you generate a custom _OSG submission package_ that can then be easily
deployed to your OSG access point.

`$ make build` generates an _OSG submission package_. This generated directory should contain all the things needed
to submit your model for execution on the OSG.

For example:

```
osg-build
├── inputs
├── logs
├── outputs
├── README.md
├── run.sh
├── src
│   ├── multiplot_function.R
│   ├── README.md
│   ├── run-behavior-space.sh
│   ├── wolf_sheep_AB.Rmd
│   └── wolf-sheep-predation.nlogo
├── submit.template
└── wolf-sheep-predation.sub
```

`$ make deploy` copies this _OSG submission package_ to your OSG login node into a `${MODEL_NAME}` directory under your OSG home directory and (eventually after we iron out all the details) submits the generated condor submit script `wolf-sheep-predation.sub` to OSG (e.g., `$ condor_submit wolf-sheep-predation.sub`.

## Input and Output Files

Behavior space output files will be placed in the `outputs` directory relative to your model OSG submission package directory on the OSG access point. They will be named `${BEHAVIOR_SPACE_EXPERIMENT}.N.csv` like this:

```
ospool-ap2040:[05:56:06] ~/wolf-sheep-predation#1230:0>
allen.lee% ls -1 outputs
vary_food_gains_osg.0.csv
vary_food_gains_osg.1.csv
vary_food_gains_osg.2.csv
vary_food_gains_osg.3.csv
vary_food_gains_osg.4.csv
```

N depends on the `queue` directive you specified. The example above is from a basic `queue 5` but a `queue experiment from experiments.txt` might look like this instead:

```
osg_irma_county_evac_output_food_stamps.output.csv
osg_irma_county_evac_output_no_factors.output.csv
osg_irma_county_evac_output_no_vehicle.output.csv
osg_irma_county_evac_output_over65.output.csv
osg_irma_county_evac_output_under18.output.csv
```

For more information, see https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html#specifying-what-files-to-transfer

## FAIR4RS Principles

The FAIR Principles for Research Software (FAIR4RS) have been published at https://doi.org/10.15497/RDA00068 and have
the following objective:

> The ultimate goal of FAIR is to increase the transparency, reproducibility, and reusability of research. For this to happen, software needs to be well-described (by metadata), inspectable, documented and appropriately structured so that it can be executed, replicated, built-upon, combined, reinterpreted, reimplemented, and/or used in different settings. The FAIR4RS Principles aim to guide software creators and owners on how to make their software FAIR. The FAIR4RS Principles are also relevant to the larger ecosystem and various stakeholders that support research software (e.g., repositories and registries).

More details and concrete guidance on how to map the FAIR4RS Principles to your GitHub repository can be found here: https://github.com/comses-education/fair-osg-template/wiki/FAIR-Principles-for-Research-Software

### Findable

> Software and its associated metadata should be easy for both humans and machines to find.

### Accessible

> Software and its metadata is retrievable via standardized protocols.

- Deposit your software in a [TRUSTed digital repository](https://www.coretrustseal.org/) like [Zenodo](https://docs.github.com/en/repositories/archiving-a-github-repository/referencing-and-citing-content) or [the CoMSES.Net Computational Model Library](https://comses.net/codebases). 
- Ensure that it is well annotated with descriptive metadata, and consider how to ensure that this metadata remains accessible even if the software itself is not

### Interoperable

> Software interoperates with other software by exchanging data and/or metadata, and/or through interaction via application programming interfaces (APIs), described through standards.

- your model should read, write, and exchange data using domain-relevant open community standards (e.g., netCDF / HDF, plaintext CSVs, domain-specific controlled vocabularies or ontologies, etc.)

### Reusable

> Software is both usable (can be executed) and reusable (can be understood, modified, built upon, or incorporated into other software).

Software can be executed and understood, modified, built upon, or incorporated into other software by [licensing it with an appropriate open source license](https://choosealicense.com). Include detailed provenance metadata, qualified persistent references to other software dependencies, and other domain-specific community standards or protocols for model documentation
