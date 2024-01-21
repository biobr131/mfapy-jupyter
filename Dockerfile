FROM condaforge/miniforge3:latest
ARG DIR_WORK
WORKDIR ${DIR_WORK}
ARG ENV_YML
ARG DIR_WORK
COPY ${ENV_YML} ${DIR_WORK}/
ARG DIR_MFAPY
COPY ${DIR_MFAPY}/ ${DIR_WORK}/${DIR_MFAPY}
ARG ENV_YML
ARG VENV
RUN conda update -y -c conda-forge conda && \
    conda env create --file ${ENV_YML} && \
    conda install -y -n ${VENV} -c conda-forge nlopt && \
    conda install -y -n ${VENV} -c anaconda mkl-service
WORKDIR ${DIR_WORK}/${DIR_MFAPY}
RUN python setup.py install
WORKDIR ${DIR_WORK}
ARG DIR_CONDA
ENV PATH ${DIR_CONDA}/envs/${VENV}/bin:$PATH
SHELL ["conda", "run", "--name", "mfa", "/bin/bash", "-c"]
ARG REQ_TXT
COPY ${REQ_TXT} ${DIR_WORK}/
RUN pip install --upgrade pip && \
    pip install -r ${REQ_TXT}
