FROM centos:centos6
MAINTAINER Riccardo Vianello riccardo.vianello@gmail.com

RUN yum update
RUN yum install wget -y
RUN yum groupinstall "Development tools" -y

RUN cd /tmp
RUN wget http://repo.continuum.io/miniconda/Miniconda-3.7.0-Linux-x86_64.sh
RUN /bin/bash ./Miniconda-3.7.0-Linux-x86_64.sh -b -p /opt/miniconda
RUN export PATH=/opt/miniconda/bin:$PATH
RUN conda install conda-build --yes

RUN git clone git clone https://github.com/rdkit/conda-rdkit
RUN cd conda-rdkit
RUN git checkout development

RUN conda build boost
RUN conda build rdkit
RUN conda build rdkit-postgresql
RUN CONDA_PY=26 conda build boost
RUN CONDA_PY=26 conda build rdkit
RUN CONDA_PY=26 conda build rdkit-postgresql
RUN CONDA_PY=34 conda build boost
RUN CONDA_PY=34 conda build rdkit
RUN CONDA_PY=34 conda build rdkit-postgresql

