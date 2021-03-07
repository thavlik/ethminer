FROM nvidia/cuda:10.1-devel
RUN apt update \
    && apt-get install -y \
        git \
        build-essential \
        cmake \
        mesa-common-dev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean
WORKDIR /ethminer
COPY . .
RUN mkdir build \
    && cd build \
    && cmake \
        -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-10.1 \
        -D CUDA_NVCC_EXECUTABLE=/usr/local/cuda-10.1/bin/nvcc \
        -D CUDA_INCLUDE_DIRS=/usr/local/cuda-10.1/include \
        -D CUDA_CUDART_LIBRARY=/usr/local/cuda-10.1/lib64/libcudart.so \
        .. \
    && make install
CMD ["ethminer"]
