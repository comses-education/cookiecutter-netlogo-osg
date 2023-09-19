# Cookiecutter NetLogo OSG template

This repository provides opinionated scaffolding and support for [NetLogo models](https://ccl.northwestern.edu/netlogo/) in an effort to help our research community adopt:

- [the Findable, Accessible, Interoperable, and Reusable Principles for Research Software (FAIR4RS)](https://doi.org/10.15497/RDA00068)
- [the Open Science Grid](https://osg-htc.org/), an open pool of compute resources contributed by university campuses,
  government-supported supercomputing institutions and research collaborations and available via fair-share access (no
  allocation needed!) to researchers conducting Open Science
- [good practices for containerization and codebase organization](https://www.comses.net/education/responsible-practices/)

Containerization recipes for [Docker](https://docs.docker.com) and [Apptainer](https://apptainer.org/) and containerized
execution on the [Open Science Grid (OSG)](https://opensciencegrid.org/).

The included Makefile has the following targets:

- build
- clean
- deploy
- docker-build
- docker-run

## FAIR4RS Principles

More details at [our FAIR template repository's wiki](https://github.com/comses-education/fair-osg-template/wiki/FAIR-Principles-for-Research-Software).

- [ ] **Findable**: create a persistent identifier for each released / published version of the software
- [ ] **Accessible**: deposit your software in a [TRUSTed digital repository](https://www.coretrustseal.org/) like [Zenodo](https://docs.github.com/en/repositories/archiving-a-github-repository/referencing-and-citing-content) or [the CoMSES.Net Computational Model Library](https://comses.net/codebases). Ensure that it is well annotated with descriptive metadata, and consider how to ensure that this metadata remains accessible even if the software itself is not
- [ ] **Interoperable**: your model should read, write, and exchange data using domain-relevant open community standards (e.g., netCDF / HDF, plaintext CSVs, domain-specific controlled vocabularies or ontologies, etc.)
- [ ] **Reusable**: Software can be executed and understood, modified, built upon, or incorporated into other software by [licensing it with an appropriate open source license](https://choosealicense.com). Include detailed provenance metadata, qualified persistent references to other software dependencies, and other domain-specific community standards or protocols for model documentation
