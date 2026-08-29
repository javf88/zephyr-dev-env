FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    cmake \
    python3-dev \
    pip

ADD --checksum=sha256:d79c5bfc68e679488659bea289a4026e52a64f03338875c8c9c850fff13cee30 \
    https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v1.0.1/zephyr-sdk-1.0.1_linux-aarch64_minimal.tar.xz /opt
RUN tar xvf /opt/zephyr-sdk-1.0.1_linux-aarch64_minimal.tar.xz -C /opt && \
    rm /opt/zephyr-sdk-1.0.1_linux-aarch64_minimal.tar.xz && \
    cmake -P /opt/zephyr-sdk-1.0.1/cmake/zephyr_sdk_export.cmake

ADD zephyr /opt/zephyr
RUN cmake -P /opt/zephyr/share/zephyr-package/cmake/zephyr_export.cmake && \
    cmake -P /opt/zephyr/share/zephyrunittest-package/cmake/zephyr_export.cmake
RUN pip install -r /opt/zephyr/scripts/requirements.txt --break-system-packages

WORKDIR /opt/zephyr

RUN apt clean && \
    rm -rf /var/lib/{apt,dpkg,cache,log}
