# Cookiecutter NetLogo OSG template

This repository provides opinionated scaffolding and support for [NetLogo models](https://ccl.northwestern.edu/netlogo/) in an effort to help our research community adopt:

- [the Findable, Accessible, Interoperable, and Reusable Principles for Research Software (FAIR4RS)](https://doi.org/10.15497/RDA00068)
- [the Open Science Grid](https://osg-htc.org/), an open pool of compute resources contributed by university campuses,
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

If upstream changes or improvements are made to this cookiecutter template you should be able to apply those changes by running

```bash
cruft update
```

## FAIR4RS Principles

The FAIR Principles for Research Software [FAIR4RS](https://doi.org/10.15497/RDA00068) list the following objective:

> The ultimate goal of FAIR is to increase the transparency, reproducibility, and reusability of research. For this to happen, software needs to be well-described (by metadata), inspectable, documented and appropriately structured so that it can be executed, replicated, built-upon, combined, reinterpreted, reimplemented, and/or used in different settings. The FAIR4RS Principles aim to guide software creators and owners on how to make their software FAIR. The FAIR4RS Principles are also relevant to the larger ecosystem and various stakeholders that support research software (e.g., repositories and registries).

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
