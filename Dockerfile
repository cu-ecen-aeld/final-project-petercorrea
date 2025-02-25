FROM arm64v8/ubuntu

RUN apt-get update && apt-get install -y build-essential chrpath cpio debianutils diffstat file gawk gcc git \
    iputils-ping libacl1 liblz4-tool locales python3 python3-git python3-jinja2 python3-pexpect \
    python3-pip python3-subunit socat texinfo unzip wget xz-utils zstd && rm -rf /var/lib/apt/lists/*

RUN apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

ENV LANG en_US.utf8

# Create a non-root user to run the build
ARG USERNAME
ARG USER_UID
ARG USER_GID

# match container permissions to that of host
RUN useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME
RUN chown -R $USERNAME:$USER_GID /home/$USERNAME
RUN mkdir -p /etc/sudoers.d && echo "yocto ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/yocto
RUN chmod 0440 /etc/sudoers.d/$USERNAME

# setup working environment
ENV HOME=/home/$USERNAME
USER $USERNAME
WORKDIR /home/$USERNAME
