FROM centos:centos6

RUN yum update -y
RUN yum install wget -y
RUN yum install tar -y
RUN yum groupinstall "Development tools" -y

RUN useradd rdkit
USER rdkit

WORKDIR /home/rdkit

RUN wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
RUN /bin/bash ./Miniconda-latest-Linux-x86_64.sh -b

ENV PATH /home/rdkit/miniconda/bin:$PATH

RUN conda update conda --yes --quiet
RUN conda install jinja2 conda-build --yes --quiet

RUN git clone https://github.com/rdkit/conda-rdkit

WORKDIR conda-rdkit

RUN git checkout development

RUN conda build boost --quiet --no-binstar-upload
RUN conda build rdkit --quiet --no-binstar-upload
RUN conda build ncurses --quiet --no-binstar-upload
RUN conda build postgresql --quiet --no-binstar-upload
RUN conda build rdkit-postgresql --quiet --no-binstar-upload

RUN CONDA_PY=34 conda build boost --quiet --no-binstar-upload
RUN CONDA_PY=34 conda build rdkit --quiet --no-binstar-upload

