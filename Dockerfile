FROM centos:centos6

RUN \
    yum update -y && \
    yum install wget -y && \
    yum install tar -y && \
    yum groupinstall "Development tools" -y

RUN useradd rdkit

RUN mkdir /home/rdkit/recipes
WORKDIR /home/rdkit/recipes

COPY boost ./boost
COPY nox ./nox
COPY cairo_nox ./cairo_nox
COPY cairocffi ./cairocffi
COPY eigen ./eigen
COPY rdkit ./rdkit
COPY ncurses ./ncurses
COPY postgresql ./postgresql
COPY rdkit-postgresql ./rdkit-postgresql
COPY postgresql95 ./postgresql95
COPY rdkit-postgresql95 ./rdkit-postgresql95

RUN chown -R rdkit:rdkit .

WORKDIR /home/rdkit
USER rdkit

RUN wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
RUN /bin/bash ./Miniconda-latest-Linux-x86_64.sh -b -p /home/rdkit/miniconda

ENV PATH /home/rdkit/miniconda/bin:$PATH

RUN \
    conda update conda --yes --quiet && \
    conda install jinja2 conda-build anaconda-client --yes --quiet

# on centos6 the max path length for a unix socket is 107 characters. this
# limit is exceeded when the postgresql build is located under the default
# filesystem path.
#
# with the current conda implementation (conda 4.2.13 - conda-build 2.0.10)
# the following $CONDA_BLD_PATH settings are sufficient to work around the
# problem.
#
# (as a side effect, packages will be found in /home/rdkit/bld/linux-64)
RUN mkdir /home/rdkit/bld
ENV CONDA_BLD_PATH /home/rdkit/bld

WORKDIR /home/rdkit/recipes

RUN \
    conda build boost --quiet --no-anaconda-upload && \
    conda build nox --quiet --no-anaconda-upload && \
    conda build cairo_nox --quiet --no-anaconda-upload && \
    conda build cairocffi --quiet --no-anaconda-upload && \
    conda build eigen --quiet --no-anaconda-upload && \
    conda build rdkit --quiet --no-anaconda-upload && \
    conda build ncurses --quiet --no-anaconda-upload && \
    conda build postgresql --quiet --no-anaconda-upload && \
    conda build rdkit-postgresql --quiet --no-anaconda-upload && \
    conda build postgresql95 --quiet --no-anaconda-upload && \
    conda build rdkit-postgresql95 --quiet --no-anaconda-upload && \
    CONDA_PY=35 conda build boost --quiet --no-anaconda-upload && \
    CONDA_PY=35 conda build nox --quiet --no-anaconda-upload && \
    CONDA_PY=35 conda build cairo_nox --quiet --no-anaconda-upload && \
    CONDA_PY=35 conda build cairocffi --quiet --no-anaconda-upload && \
    CONDA_PY=35 conda build eigen --quiet --no-anaconda-upload && \
    CONDA_PY=35 conda build rdkit --quiet --no-anaconda-upload && \
    CONDA_PY=35 conda build postgresql --quiet --no-anaconda-upload && \
    CONDA_PY=35 conda build rdkit-postgresql --quiet --no-anaconda-upload && \
    CONDA_PY=35 conda build postgresql95 --quiet --no-anaconda-upload && \
    CONDA_PY=35 conda build rdkit-postgresql95 --quiet --no-anaconda-upload && \
    CONDA_NPY=110 conda build rdkit --quiet --no-anaconda-upload && \
    CONDA_PY=35 CONDA_NPY=110 conda build rdkit --quiet --no-anaconda-upload

