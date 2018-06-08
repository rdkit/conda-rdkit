FROM centos:centos6
MAINTAINER Greg Landrum <greg.landrum@t5informatics.com>

ARG anaconda_token
ARG anaconda_user

RUN yum update -y && yum install -y \
  wget \
  gcc-c++ \
  git \
  cairo \
  libXext \
  patch \
  cmake

# conda
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.3.11-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-4.3.11-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-4.3.11-Linux-x86_64.sh

ENV PATH /opt/conda/bin:$PATH
ENV LANG C

# actually do the conda install
RUN conda config --prepend channels  https://conda.anaconda.org/rdkit
RUN conda config --append channels  https://conda.anaconda.org/conda-forge
RUN conda install -y nomkl numpy=1.13 boost=1.56 eigen conda-build=2.1.17 anaconda-client


RUN mkdir /src
WORKDIR /src
RUN git clone https://github.com/rdkit/conda-rdkit
WORKDIR /src/conda-rdkit
RUN git checkout development

RUN \
    conda build nox --quiet --no-anaconda-upload && \
    conda build cairo_nox --quiet --no-anaconda-upload && \
    CONDA_PY=35 conda build rdkit --quiet --user=$anaconda_user --token=$anaconda_token && \
    CONDA_PY=36 conda build rdkit --quiet --user=$anaconda_user --token=$anaconda_token && \
    CONDA_PY=27 conda build rdkit --quiet --user=$anaconda_user --token=$anaconda_token
