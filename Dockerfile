################## BASE IMAGE ######################

FROM continuumio/miniconda:4.5.12

################## METADATA ######################

LABEL base_image="continuumio/miniconda:latest"
LABEL version="1"
LABEL software=""
LABEL software.version="4.5.12"
LABEL about.summary="jupyter"
LABEL about.home="https://github.com/byee4/mybinder"
LABEL about.documentation=""
LABEL about.license_file=""
LABEL about.license=""
LABEL about.tags="Genomics"

################## MAINTAINER ######################
MAINTAINER Brian Yee <brian.alan.yee@gmail.com>
ENV NB_USER brian
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

RUN pip install --no-cache-dir notebook==5.*
RUN conda install pandas \
  numpy \
  scikit-learn \
  matplotlib=2.1.1 \
  basemap \
  jupyter

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

WORKDIR /home/${NB_USER}
