FROM nvidia/cuda:11.4.0-base

# Install Python 3.9
RUN apt-get update && apt-get install -y \
    python3.9 \
    python3.9-dev \
    python3.9-distutils

# Install pip and some common packages
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.9 get-pip.py && \
    pip install --no-cache-dir \
    numpy \
    pandas \
    matplotlib \
    tensorflow-gpu \
    langflow

# Set up the environment
ENV PATH="/root/.local/bin:${PATH}"
ENV PYTHONPATH="/app:${PYTHONPATH}"
WORKDIR /app

# Expose the ports for Jupyter Notebook
EXPOSE 8888

# Set up the entrypoint command to run Jupyter Notebook
CMD ["curl ifconfig.me", "jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
