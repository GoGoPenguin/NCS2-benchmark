FROM ubuntu:16.04

USER root

WORKDIR /root/ncsdk

ARG DOWNLOAD_LINK=http://registrationcenter-download.intel.com/akdlm/irc_nas/15792/l_openvino_toolkit_p_2019.2.275.tgz

ARG PSET_INSTALL_DIR=/opt/intel

ARG TEMP_DIR=/tmp/openvino_installer

# update and upgrade
RUN apt-get update \
    && apt-get upgrade -y

# install dependency
RUN apt-get install -y \
    software-properties-common \
    build-essential \
    lsb-release \
    usbutils \
    udev \
    wget \
    sudo \
    curl \
    make \
    cpio \
    vim

# install git
RUN apt-add-repository ppa:git-core/ppa \
    && apt-get update \
    && apt-get install -y git

# install the OpenVINO™ Toolkit
RUN mkdir -p $TEMP_DIR \
    && cd $TEMP_DIR \
    && wget -c $DOWNLOAD_LINK \
    && tar xf l_openvino_toolkit*.tgz \
    && cd l_openvino_toolkit* \
    && sed -i 's/decline/accept/g' silent.cfg \
    && sudo -E ./install_openvino_dependencies.sh \
    && ./install.sh -s silent.cfg \
    && rm -rf $TEMP_DIR

# configure Neural Compute Stick USB Driver
RUN /bin/bash -c "source ${PSET_INSTALL_DIR}/openvino/bin/setupvars.sh \
    && cd ${PSET_INSTALL_DIR}/openvino/install_dependencies \
    && ./install_NCS_udev_rules.sh" \
    && echo "source /opt/intel/openvino/bin/setupvars.sh" >> ~/.bashrc

# model optimizer configuration
RUN cd ${PSET_INSTALL_DIR}/openvino/deployment_tools/model_optimizer/install_prerequisites/ \
    && ./install_prerequisites.sh

# add source code
ADD src .

# install python requirement
RUN python3 -m pip install --upgrade pip setuptools \
    && python3 -m pip install -r requirement.txt
