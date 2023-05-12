# See here for image contents: https://hub.docker.com/r/jupyter/datascience-notebook/

FROM jupyter/datascience-notebook

# We want to run common-debian.sh from here:
# https://github.com/microsoft/vscode-dev-containers/tree/main/script-library#development-container-scripts
# But that script assumes that the main non-root user (in this case jovyan)
# is in a group with the same name (in this case jovyan).  So we must first make that so.
COPY library-scripts/common-debian.sh /tmp/library-scripts/
USER root
RUN apt-get update \
 && groupadd ${NB_USER} \
 && usermod -g ${NB_USER} -a -G users ${NB_USER} \
 && bash /tmp/library-scripts/common-debian.sh \
 && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts
#  && conda install -c conda-forge radian \
#  && mamba install --yes \
#     'radian'
#     'languageserver' \
#     'httpgd' \
#  && mamba clean --all -f -y \
#  && fix-permissions "${CONDA_DIR}" \
#  && fix-permissions "/home/${NB_USER}"
#  && Rscript -e 'install.packages("languageserver",repos = "https://mirrors.dotsrc.org/cran/")\n\
# install.packages("httpgd",repos = "https://mirrors.dotsrc.org/cran/")'
#  && rm -rf /home/jovyan/work \
#  && ln -s /workspace/src /home/jovyan/workspace

# [Optional] If your pip requirements rarely change, uncomment this section to add them to the image.
# COPY requirements.txt /tmp/pip-tmp/
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends python3-pip python3-opencv \
#     && conda create --name tf python=3.9 \
#     && conda activate tf \
#     && conda install -c conda-forge cudatoolkit=11.8.0 \
#     && pip install nvidia-cudnn-cu11==8.6.0.163 \
#     && mkdir -p $CONDA_PREFIX/etc/conda/activate.d \
#     && echo 'CUDNN_PATH=$(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh \
#     && echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/:$CUDNN_PATH/lib' >> $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh \
#     && pip install --upgrade pip \
#     && pip install tensorflow==2.12.* \
#     && pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt \
#     && rm -rf /tmp/pip-tmp

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    pandoc wkhtmltopdf
    # python3-opencv
    # nvidia-cuda-toolkit

# RUN conda install -c conda-forge radian \
#     && Rscript -e 'install.packages("languageserver",repos = "https://mirrors.dotsrc.org/cran/")\n\
# install.packages("httpgd",repos = "https://mirrors.dotsrc.org/cran/")'

ENV NOTEBOOK_ARGS="--notebook-dir=/workspace/src ${NOTEBOOK_ARGS}"

USER ${NB_UID}

# SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN mamba install --yes \
    'tensorflow' \
    'ipykernel' \
    'radian' \
    'r-httpgd' \
    'r-languageserver' \
    'r-irkernel' \
 && mamba clean --all -f -y \
 && Rscript -e 'IRkernel::installspec()' \
 && fix-permissions "${CONDA_DIR}" \
 && fix-permissions "/home/${NB_USER}" \
 && chmod -R go-w /home/${NB_USER}/.oh-my-zsh

# WORKDIR /workspace/src
