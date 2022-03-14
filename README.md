# lmit-ds-template

[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

This is a template project to be used as a standard, for any Python project developed by LMIT Data Science team.

## Repository initialization 

The template needs to be first initialised after creation using the script `bin/init_repo.sh`. 
The script will ask the user few informations and take care of adapting configurations files accordingly. 
Multiple Python versions (3.6+) are supported. 
Depending on the selected Python version different requirements, CI/CD pipelines, 
docker images, etc should be considered. The `bin/init_repo.sh` will take care of 
setting up these files consistently.

```
bash bin/init_repo
```

**NOTE:** In the process, you will also be asked if you want to *remove the templates*, 
in order to keep your repo minimal and avoid cluttering. 
Please keep in mind that if you do so, you won't be able to re-initialise the files 
in your repository again. 

## Makefile 

The process of installation of requirements, packaging, running checks (static typing, linting, unittests, etc) is 
done using Makefile. To install the developed package and all its dependencies run

```
make install  # to build source and install package
```

For further information on the make commands, run

```
make help
```


## Requirements

This template uses ``pip-tools`` to keep track of requirements. In particular there is a ``requirements`` folder 
containing a ``requirements.in, requirements.txt, requirements_ci.in, requirements_ci.txt`` files corresponding to 
input (``*.in``) and actual (``*.txt``) requirements files for CI and package.


## Toolset for the project

### Coding style
This template uses ``black`` (https://github.com/psf/black) for formatting and enforcing a coding style.
Run ``make format`` to reformat all source code and tests files to adhere to PEP8 standards.

### Linting
We use ``flake8`` (https://github.com/PyCQA/flake8) for static code analysis. The configuration file is included in ``setup.cfg``. 
It coincides with the configuration suggested by the ``black`` developers. Run ``make lint`` to analyse all source code and tests files.

### Type hints
We use ``mypy`` for static type checking. The configuration is included in ``setup.cfg``.
The only settings included in this configuration files are related to the missing typing annotations of some common third party libraries.

### Documentation
This project uses `Sphinx` (https://www.sphinx-doc.org/en/master/) as a tool to create documentation. Run `make docs` to build documentation.
There is a github workflow setup to publish documentation on the repo's Github Page at every push on `main` branch. 

### Github workflows
This template automatically sets up three different github workflows.  

* **Continous Integration**: this workflow is activated on pull requests. It runs `make checks` and `make docs` to check that autmatic documentation, unit-tests, linting, typing and formatting are all compliant with predefined rules. The result of this workflow is reported in the PR and could be used to block merging in case of failure (but this is not set by default in the template, it's left to the user the choice of setting this option in its own repo)

* **Continous Delivery**: this workflow is activated when pushing tags with message starting with "v" on `main` branch. It builds the binary and wheel sources, checks that their structure is correct, runs unit-tests, linting, typing and formatting checks and releases the sources on the github repository. This action requires a GITHUB_TOKEN: this could be personal (default setting, already implemented) or can be a service token for the organization or the repository (check Settings > Secrets > Actions on your newly created repository to asses the existence of these tokens or create them). In case the newly creted repository contains the code for a Python application this workflow could be extended manually adding steps to build a Docker image and deploy it wherever defined.

* **Build and Deploy Docs on Github Page**: this workflow is activated when pushing on `main` branch. It builds documentation using `make docs` command and uploads them on repo's Github page. To let this action run smoothly there must exist the `gh_pages` branch in the new repository (if it does not exists yet the workflow will create it) and the Github Page must be manually setted (from github repo web interface > Settings > Pages) to use `gh_pages` as source branch and `/root` as source folder. 
Since this action requires a GITHUB_TOKEN, for its first run in the repo it will be necessary to follow the steps  detailed [here]( https://github.com/peaceiris/actions-gh-pages#%EF%B8%8F-first-deployment-with-github_token)  to make the action run fine from then on.


### Semantic Versioning

The present template had already set up the versioneer using the procedure described below. The configuration is included in ``setup.cfg``. This implements automatically a semantinc versioning based on tags: Major, Minor and Patch numbers will be searched in tags of the form `vMAJOR.MINOR.PATCH` in the previous history of the branch and will be used when building the package. If one is not building the package from a tagged commit, the version number will also include an hash representing the build number and, possibili, a "dirty" postfix if there are changes yet to be committed at the moment of building the package.


#### Verisioneer setup
**The following procedure had already been run and is reported only for documentation purposes, no need to re-run it.**
1. First of all we need to install the versioneer package from pip
```
$ pip install versioneer
```

2. Then we edit the versioneer section in the setup.cfg

```
[versioneer]
VCS = git
style = pep440
versionfile_source = {{SRC}}/_version.py
versionfile_build = {{SRC}}/_version.py
tag_prefix = v
parentdir_prefix = {{PROJECT_NAME}}
```

3. Next, we need to install the versioneer module into our project.
```
versioneer install
```

Running this command will create a few new files for us in our project and also ask us to make some changes to our setup.py file. We need to import versioneer in the setup, replace the version keyword argument with versioneer.get_version() and add a new argument cmdclass=versioneer.get_cmdclass().

```
setuptools.setup(
    ...
    version=versioneer.get_version(),
    cmdclass=versioneer.get_cmdclass(),
    ...
)
```
 for full documentation [versioneer GitHub repo](https://github.com/python-versioneer/python-versioneer)