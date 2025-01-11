FROM python:3.12

ARG DIR_WORK
WORKDIR ${DIR_WORK}

ARG REQ_TXT
COPY ${REQ_TXT} ${DIR_WORK}/
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r ${REQ_TXT}

ARG DIR_MFAPY
COPY ${DIR_MFAPY}/ ${DIR_WORK}/${DIR_MFAPY}
WORKDIR ${DIR_WORK}/${DIR_MFAPY}
RUN python -m pip install .
