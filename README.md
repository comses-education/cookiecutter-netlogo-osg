# Cookiecutter NetLogo OSG template

This repository provides opinionated scaffolding and support for [NetLogo models](https://ccl.northwestern.edu/netlogo/) in an effort to help our research community adopt:

- [the Findable, Accessible, Interoperable, and Reusable Principles for Research Software (FAIR4RS)](https://doi.org/10.15497/RDA00068)
- [the Open Science Grid Consortium's](https://osg-htc.org/), [Open Science Pool (OSPool)](https://osg-htc.org/services/open_science_pool.html), an open access pool of compute resources contributed by university campuses,
  government-supported supercomputing institutions and research collaborations and available via fair-share access (no
  allocation needed!) to researchers conducting Open Science
- [good practices for containerization and codebase organization](https://www.comses.net/education/responsible-practices/)

Containerization recipes for [Docker](https://docs.docker.com), [Apptainer](https://apptainer.org/) and
execution on the [Open Science Grid (OSG)](https://opensciencegrid.org/) are also included but may require additional
customization.

The included Makefile has the following targets:

- build
- clean
- deploy
- docker-build
- docker-run

## How to use this template

Install [cruft](https://cruft.github.io/cruft/) via `$ pip install cruft` [or other methods](https://cruft.github.io/cruft/#installation) and run

```bash
cruft create https://github.com/comses-education/cookiecutter-netlogo-osg
```

Which should bring up output like the following:

```bash
  [1/20] given_name (Allen): 
  [2/20] family_name (Lee): 
  [3/20] full_name (Allen Lee): 
  [4/20] email (allen.lee@mailinator.com): allen.lee@asu.edu
  [5/20] orcid (https://orcid.org/0000-0002-1825-0097): 
  [6/20] affiliation (https://ror.org/015bsfc29): 
  [7/20] github_repository (https://github.com/your-github-username/your-netlogo-osg-repo): 
  [8/20] java_tool_options (-Xmx4G): 
  [9/20] osg_username (allen.lee): 
  [10/20] project_name (My First FAIR+OSG NetLogo Model): Wolf Sheep Predation          
  [11/20] model_slug (wolf-sheep-predation): wolf-sheep
  [12/20] model_file (wolf-sheep.nlogo): 
  [13/20] model_short_description (A FAIR+OSG NetLogo model that tells a harrowing tale of turtles and grids): A FAIR+OSG NetLogo model that tells a harrowing tale of wolf and sheep.
  [14/20] behavior_space_experiment (osg_behavior_space_experiment): osg_vary_food_gains
  [15/20] entrypoint_script (run.sh): 
  [16/20] osg_queue_directive (5): 10
  [17/20] version (1.0.0): 
  [18/20] create_citation_file (y): 
  [19/20] Select license
    1 - MIT
    2 - Apache-2.0
    3 - ISC
    4 - GPL-3.0-or-later
    5 - GPL-2.0-or-later
    6 - NA
    Choose from [1/2/3/4/5/6] (1): 1
  [20/20] contributors (default): 
>>> elapsed time 1m10s   
```

Answer the cookiecutter questions as needed (don't stress if you don't put down the correct answer, these can always be further updated later via `cruft update -i`).

Place your NetLogo file in the `src/` directory. Your main NetLogo model file should be identical to what you entered or used as the default for the `model_file` field, so in the example above we should have a `src/wolf-sheep.nlogo` file.

When improvements are made to this cookiecutter template you can apply those changes by running

```bash
cruft update
```

Or if you'd like to alter any of the values you entered, run

```bash
cruft update -i
```

in the root directory of your cookiecutter generated template.

Directory structure:

- src/ - Place your NetLogo file(s) in the `src/` directory.
- inputs/ - Place your input data dependencies or document persistent URLs / DOIs / links to input data dependencies in the README
- results/ - Place generated figures here
- notebooks/ - Place interactive / Jupyter notebooks here.

NOTE: Be aware of file size and take care not to [exceed your GitHub disk quota](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-large-files-on-github)

After generating your cookiecutter repository and adding your source NetLogo files and any input dependencies you can build an OSG submission package by running

```bash
make build
```

This will create a directory `osg-build` that contains all the things we'll want to copy over to your OSG access point, primarily bash scripts and HTCondor submission scripts. Feel free to edit these as needed, and if there are any additional use cases you think we should support in this template, please let us know!
 
## FAIR4RS Principles

> The ultimate goal of FAIR is to increase the transparency, reproducibility, and reusability of research. For this to happen, software needs to be well-described (by metadata), inspectable, documented and appropriately structured so that it can be executed, replicated, built-upon, combined, reinterpreted, reimplemented, and/or used in different settings. The FAIR4RS Principles aim to guide software creators and owners on how to make their software FAIR. The FAIR4RS Principles are also relevant to the larger ecosystem and various stakeholders that support research software (e.g., repositories and registries).

[Full text for the FAIR Principles for Research Software (FAIR4RS)](https://doi.org/10.15497/RDA00068) 

### Findable

> Software and its associated metadata should be easy for both humans and machines to find.

### Accessible

> Software and its metadata is retrievable via standardized protocols.

### Interoperable

> Software interoperates with other software by exchanging data and/or metadata, and/or through interaction via application programming interfaces (APIs), described through standards.


### Reusable

> Software is both usable (can be executed) and reusable (can be understood, modified, built upon, or incorporated into other software).

More details and concrete guidance on how to map the FAIR4RS Principles to your GitHub repository can be found at https://github.com/comses-education/fair-osg-template/wiki/FAIR-Principles-for-Research-Software but a basic checklist follows:

- publish your software in a [TRUSTed digital repository](https://www.comses.net/resources/trusted-digital-repositories/). One convenient pathway from this github repo is to enable [Zenodo](https://docs.github.com/en/repositories/archiving-a-github-repository/referencing-and-citing-content) to mint a DOI for every GitHub release you create.
- add comprehensive descriptive metadata and provenance metadata to your software and include explicit, persistent references to all of its software or data dependencies 
- ensure that this descriptive metadata remains accessible even if the software itself is not
- [select an appropriate open source license](https://choosealicense.com)
- read, write, and exchange data using domain-relevant open community standards, e.g., netCDF / HDF, plaintext CSVs, and leverage [domain-specific controlled vocabularies / ontologies](http://esipfed.github.io/cor/) where possible
