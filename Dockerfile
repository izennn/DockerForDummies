FROM nvidia/cuda:9.0-cudnn7-runtime

LABEL maintainer 'jhkimac'

# Install Python
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  build-essential \
  curl \
  software-properties-common \
  python3-pip \
  && add-apt-repository -y ppa:jonathonf/python-3.6 \
  && apt-get update \
  && apt-get install -y python3.6 python3.6-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN python3.6 -m pip install --no-cache-dir -U pip
RUN python3.6 -m pip install --no-cache-dir -U setuptools
RUN ln -s /usr/bin/python3.6 /usr/bin/python

CMD ["python"]