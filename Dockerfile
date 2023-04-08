FROM golang:1.19

# install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    make \
    npm \
    jq \
    wget  \
    hwloc  \
    ocl-icd-opencl-dev \
    libhwloc-dev  \
    pkg-config  \
    make \
    cargo

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs

# install rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# clone repositories
RUN git clone https://github.com/application-research/delta.git \
    && git clone https://github.com/application-research/delta-dm.git \
    && git clone https://github.com/application-research/delta-nextjs-client.git

# build apps
RUN cd delta && RUSTFLAGS="-C target-cpu=native -g" FFI_BUILD_FROM_SOURCE=1 FFI_USE_BLST_PORTABLE=1 make all \
    && cd ../delta-dm && make build \
    && cd ../delta-nextjs-client && npm install && npm run build

# set up environment variables
ENV DELTA_ENV /delta.env
RUN touch $DELTA_ENV
RUN chmod +xrw $DELTA_ENV

# obtain or load API key
RUN if [ -f "$DELTA_ENV" ]; then \
        echo "| loading existing api key from .env"  \
        && . $DELTA_ENV; \
    else \
        echo "| obtaining a new api key" \
        && touch $DELTA_ENV \
        && API_KEY=$(curl -s --location --request GET 'https://auth.estuary.tech/register-new-token' | jq -r .token) \
        && echo "| your DELTA API key is: $API_KEY" \
        && echo "| >> Please save this key for future requests" \
        && echo -e "set -a\nDELTA_AUTH=$API_KEY\nset +a" > $DELTA_ENV \
        && export DELTA_AUTH=$API_KEY \
        && source $DELTA_ENV; \
    fi

# copy script files
WORKDIR /app
COPY start.sh .
COPY stop.sh .
COPY update.sh .
#COPY delta-upload.sh .

# set up entrypoint
ENTRYPOINT ["./start.sh"]
