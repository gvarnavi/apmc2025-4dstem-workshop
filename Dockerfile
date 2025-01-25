# slim uv base image
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

# uv optimization env variables
ENV UV_COMPILE_BYTECODE=1
ENV UV_SYSTEM_PYTHON=1

# install deps (system is safe, already isolated)
COPY ./requirements.in .
RUN uv pip install -r requirements.in

# create user with a home directory for binder
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# run jupyterlab
CMD ["jupyter", "lab"]
