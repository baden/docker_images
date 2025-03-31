# Вихідний образ на базі Ubuntu 20.04 (можна змінити на іншу версію)
FROM ubuntu:20.04

# Забороняємо інтерактивні запити під час встановлення пакетів
ENV DEBIAN_FRONTEND=noninteractive

# Оновлюємо пакети та встановлюємо основні залежності:
# python3, python3-pip, git, wget, build-essential, cmake, ninja-build, gperf, ccache,
# device-tree-compiler, xxd та утиліту для crc32 (зазвичай міститься в пакеті libarchive-zip-perl)
RUN apt-get update && \
    apt-get install -y \
      python3 python3-pip python3-setuptools python3-wheel \
      git wget \
      build-essential \
      cmake \
      ninja-build \
      gperf \
      ccache \
      device-tree-compiler \
      xxd libarchive-zip-perl \
    && rm -rf /var/lib/apt/lists/*

# Встановлюємо west через pip
RUN pip3 install --no-cache-dir west

# Переходимо в робочу директорію для подальших завантажень
WORKDIR /opt

# --- Завантаження Zephyr SDK (тільки для arm-zephyr-eabi) ---
# Замініть <ARM_ZEPHYR_EABI_SDK_URL> на URL, за яким доступний архів потрібного SDK
# RUN wget -O zephyr-sdk-arm.tar.gz "<ARM_ZEPHYR_EABI_SDK_URL>" && \
#     mkdir zephyr-sdk && \
#     tar -xzf zephyr-sdk-arm.tar.gz -C zephyr-sdk --strip-components=1 && \
#     rm zephyr-sdk-arm.tar.gz

# # --- Завантаження Zephyr (гілка v4.1.0-rc3) ---
# RUN git clone --branch v4.1.0-rc3 https://github.com/zephyrproject-rtos/zephyr.git /opt/zephyr

# # Задаємо змінну оточення для Zephyr
# ENV ZEPHYR_BASE=/opt/zephyr

# Завдання за замовчуванням
CMD ["/bin/bash"]
