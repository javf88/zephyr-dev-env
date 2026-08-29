FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    cmake \
    python3-dev \
    pip

WORKDIR /opt

ADD --checksum=sha256:d79c5bfc68e679488659bea289a4026e52a64f03338875c8c9c850fff13cee30 \
    https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v1.0.1/zephyr-sdk-1.0.1_linux-aarch64_minimal.tar.xz /opt
RUN tar xvf zephyr-sdk-1.0.1_linux-aarch64_minimal.tar.xz && \
    cmake -P zephyr-sdk-1.0.1/cmake/zephyr_sdk_export.cmake

ADD https://github.com/zephyrproject-rtos/zephyr.git?subdir=share /opt/share
RUN cmake -P share/zephyr-package/cmake/zephyr_export.cmake && \
    cmake -P share/zephyrunittest-package/cmake/zephyr_export.cmake

ADD https://github.com/zephyrproject-rtos/zephyr.git?subdir=scripts /opt/scripts
RUN pip install -r scripts/requirements.txt --break-system-packages

RUN apt clean && \
    rm -rf /var/lib/{apt,dpkg,cache,log}
