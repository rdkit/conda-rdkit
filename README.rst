Conda recipes for the RDKit
###########################

This repository provides the recipes for building binary `RDKit <http://rdkit.org>`_ packages to be used with the Anaconda Python distribution or other conda environments.

Conda
=====

Conda is an open-source, cross-platform, software package manager. It supports the packaging and distribution of software components, and manages their installation inside isolated execution environments. It has several analogies with pip and virtualenv, but it is designed to be more "python-agnostic" and more suitable for the distribution of binary packages and their dependencies.

How to get conda
----------------

The easiest way to get Conda is having it installed as part of the `Anaconda Python distribution <http://docs.continuum.io/anaconda/install.html>`_. A possible (but a bit more complex to use) alternative is provided with the smaller and more self-contained `Miniconda <conda.pydata.org/miniconda.html>`_. The conda source code repository is available on `github <https://github.com/conda>`_ and additional documentation is provided by the project `website <http://conda.pydata.org/>`_. 

How to build the packages
=========================

Software and system requirements
--------------------------------

A recent version of conda must be installed and included in the user's PATH. If not already included by the available anaconda/miniconda installation, the 'conda build' subcommand must also be installed:: 

  $ conda install conda-build

The recipes provided with this repository perform the automated download and management of the Avalon and InChI source code distributions as part of the RDKit build process, and most of the other 3rd party dependencies are readily available from the Anaconda Python distribution. Compared to the usual RDKit build procedure, the setup and configuration part is therefore strongly simplified, but depending on the operating system a few additional components may be required:

Linux
.....

If not already installed as a dependency of the conda-build package, the patchelf utility mush be also present. It can be available with the operating system or it may be installed inside the conda root environment with the following command::

  $ conda install patchelf

Windows
.......

The recipes assume the availability of the Microsoft Visual C++ 2010 commmand-line toolchain. The freely available Express edition should provide all the necessary.

The cmake build utility should be also installed.

A git client is optionally required for building the version of the recipes which is available from the development branch.

Building the packages
---------------------

The latest stable version of these recipes (building the most recent RDKit release) may be downloaded from the following `link <https://github.com/rdkit/conda-rdkit/archive/master.zip>`_. Alternatively, users may directly clone this repository from github::

  $ git clone https://github.com/rdkit/conda-rdkit.git

Recipes for building the current development version of the RDKit are available from the development branch of the same repository.

All commands in the described build procedure are assumed to run in a shell or windows command prompt already configured to make available conda and the compiler toolchain that may be needed for the specific platform. Moreover, the working directory for the build commands described in this section is assumed to correspond with the top level directory of the recipes distribution (where this README file is located).

The build process doesn't require activating and configuring a dedicated python environment. The build commands may run within the root environment and conda will take care of automating all of the process, starting from downloading the source code and proceeding to unpacking it into a suitable working directory, creating the necessary build and test environments with the required dependencies, compiling, testing and finally storing the resulting binary packages into a local directory.

If all of the necessary conditions are satisfied, building the RDKit may then reduce to running the following two commands::

  $ conda build boost
  $ conda build rdkit

For the linux platform an additional recipe is available, supporting the build of the postgresql cartridge::

  $ conda build rdkit-postgresql

Conda will store the produced packages into a local repository/channel, by default placed inside the anaconda installation (e.g. on a linux 64 bits system the packages would be found by default under ~/anaconda/conda-bld/linux-64).

Installing and using the packages
---------------------------------

Creating a new conda environment with the RDKit installed using these  packages requires one single command similar to the following::

  $ conda create -c <channel-url> -n my-rdkit-env rdkit

where '<channel-url>' is to be replaced with the URL of the package repository where the packages have been placed for distribution.

If the packages have been built locally and are still available inside the user's conda build directories, then specifying the '--use-local' option should be sufficient and configuring a distribution channel is not necessary::

  $ conda create --use-local -n my-rdkit-env rdkit
 
A new environment will be created including the required dependencies::

  Fetching package metadata: ...
  Solving package specifications: .
  Package plan for installation in environment /home/ric/anaconda/envs/my-rdkit-env:
  
  The following packages will be linked:
  
      package                    |            build
      ---------------------------|-----------------
      boost-1.55.0               |           py27_1   hard-link
      bzip2-1.0.6                |                0   hard-link
      numpy-1.8.1                |           py27_0   hard-link
      openssl-1.0.1g             |                0   hard-link
      python-2.7.6               |                1   hard-link
      rdkit-2014.03.1pre         |       np18py27_1   hard-link
      readline-6.2               |                2   hard-link
      sqlite-3.7.13              |                0   hard-link 
      system-5.8                 |                1   hard-link
      tk-8.5.15                  |                0   hard-link
      zlib-1.2.7                 |                0   hard-link
  
  Proceed ([y]/n)? y

Finally, the new environment must be activated, so that the corresponding python interpreter becomes available in the same shell::

  $ source activate my-rdkit-env

Windows users will use a slightly different command::

  C:\> activate my-rdkit-env

