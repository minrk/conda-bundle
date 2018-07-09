FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -yq dist-upgrade \
 && apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    locales \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen


ENV CONDA_DIR=/opt/conda \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

ENV PATH=$CONDA_DIR/bin:$PATH
RUN useradd -m -s /bin/bash -N -u 1000 user && \
    mkdir -p $CONDA_DIR && \
    chown 1000:1000 $CONDA_DIR

USER 1000

ARG MINICONDA_VERSION=4.5.4
ARG CONDA_VERSION=4.5.4
# Install conda as jovyan and check the md5 sum provided on the download site
RUN cd /tmp && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    /bin/bash Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    conda config --system --prepend channels conda-forge && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true && \
    conda install --quiet --yes conda=${CONDA_VERSION} && \
    conda install -yq requests_download progressbar2 && \
    conda clean -tipsy

ADD . /srv/conda-bundle
ENV PATH=/srv/conda-bundle:$PATH

WORKDIR /work
CMD ["/srv/conda-bundle/conda-bundle"]
